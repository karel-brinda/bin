#!/usr/bin/env python3
"""Tests for i.ai_git_attribution; every run uses a temporary HOME.

usage: python3 tests/test_i_ai_git_attribution.py
"""

import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import unittest

SCRIPT = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                      "i.ai_git_attribution")

try:
    import tomllib
except ImportError:
    tomllib = None

CLAUDE = {
    "GIT_AUTHOR_NAME": "Karel Břinda's Claude",
    "GIT_AUTHOR_EMAIL": "karel.brinda+claude@gmail.com",
    "GIT_COMMITTER_NAME": "Karel Břinda's Claude",
    "GIT_COMMITTER_EMAIL": "karel.brinda+claude@gmail.com",
}

CODEX_LINES = [
    'GIT_AUTHOR_NAME = "Karel Břinda\'s Codex"',
    'GIT_AUTHOR_EMAIL = "karel.brinda+codex@gmail.com"',
    'GIT_COMMITTER_NAME = "Karel Břinda\'s Codex"',
    'GIT_COMMITTER_EMAIL = "karel.brinda+codex@gmail.com"',
]

GEMINI_LINES = [
    'GIT_AUTHOR_NAME="Karel Břinda\'s Gemini"',
    'GIT_AUTHOR_EMAIL="karel.brinda+gemini@gmail.com"',
    'GIT_COMMITTER_NAME="Karel Břinda\'s Gemini"',
    'GIT_COMMITTER_EMAIL="karel.brinda+gemini@gmail.com"',
]

CODEX_EXISTING = """\
# Codex settings
model = "gpt-5"

[features]
x = true # keep me

[shell_environment_policy.set]
NODE_REPL_TRUSTED = "abc"
GIT_AUTHOR_NAME = "Somebody Else"

# Comment that belongs to the next table
[projects."/tmp/p"]
trust_level = "trusted"
"""

GEMINI_EXISTING = """\
# Gemini secrets
GEMINI_API_KEY=not-a-real-key
export GIT_AUTHOR_NAME='Old Name'
"""


def read(path):
    with open(path, encoding="utf-8") as f:
        return f.read()


def write(path, text):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        f.write(text)


class Base(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.mkdtemp()
        self.addCleanup(shutil.rmtree, self.tmp)
        self.home = os.path.join(self.tmp, "home")
        os.mkdir(self.home)
        self.claude = os.path.join(self.home, ".claude", "settings.json")
        self.codex = os.path.join(self.home, ".codex", "config.toml")
        self.gemini = os.path.join(self.home, ".gemini", ".env")

    def run_script(self, *args, **extra_env):
        env = dict(os.environ)
        for key in ("CLAUDE_CONFIG_DIR", "CODEX_HOME", "GEMINI_CLI_HOME",
                    "GIT_AUTHOR_NAME", "GIT_AUTHOR_EMAIL",
                    "GIT_COMMITTER_NAME", "GIT_COMMITTER_EMAIL"):
            env.pop(key, None)
        env["HOME"] = self.home
        env["PYTHONIOENCODING"] = "utf-8"
        env.update(extra_env)
        p = subprocess.Popen([sys.executable, SCRIPT] + list(args), env=env,
                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = p.communicate()
        return p.returncode, out.decode("utf-8"), err.decode("utf-8")

    def backups(self):
        return sorted(p for p in self.snapshot() if ".bak." in os.path.basename(p))

    def snapshot(self):
        result = {}
        for root, _, files in os.walk(self.home):
            for name in files:
                path = os.path.join(root, name)
                result[path] = read(path)
        return result

    def assert_toml_valid(self, path):
        if tomllib is not None:
            with open(path, "rb") as f:
                return tomllib.load(f)
        return None


class FreshInstall(Base):
    def test_creates_all_three_files(self):
        code, out, err = self.run_script()
        self.assertEqual(code, 0, err)
        self.assertEqual(json.loads(read(self.claude)), {"env": CLAUDE})
        self.assertEqual(read(self.codex),
                         "[shell_environment_policy.set]\n" + "\n".join(CODEX_LINES) + "\n")
        self.assertEqual(read(self.gemini), "\n".join(GEMINI_LINES) + "\n")
        self.assertEqual(os.stat(self.gemini).st_mode & 0o777, 0o600)
        self.assertIn("create: " + self.claude, out)
        self.assertEqual(self.backups(), [])
        data = self.assert_toml_valid(self.codex)
        if data is not None:
            self.assertEqual(data["shell_environment_policy"]["set"]["GIT_AUTHOR_NAME"],
                             "Karel Břinda's Codex")

    def test_second_run_changes_nothing(self):
        self.run_script()
        before = self.snapshot()
        code, out, err = self.run_script()
        self.assertEqual(code, 0, err)
        self.assertEqual(self.snapshot(), before)
        self.assertEqual(out.count("unchanged: "), 3)
        self.assertEqual(self.backups(), [])

    def test_dry_run_writes_nothing(self):
        code, out, err = self.run_script("--dry-run")
        self.assertEqual(code, 0, err)
        self.assertEqual(self.snapshot(), {})
        self.assertFalse(os.path.exists(os.path.join(self.home, ".claude")))
        self.assertIn("would create: " + self.codex, out)
        self.assertIn("dry run: nothing was written", out)

    def test_selected_agent_only(self):
        code, _, err = self.run_script("codex")
        self.assertEqual(code, 0, err)
        self.assertTrue(os.path.exists(self.codex))
        self.assertFalse(os.path.exists(self.claude))
        self.assertFalse(os.path.exists(self.gemini))

    def test_bad_argument(self):
        code, _, err = self.run_script("cursor")
        self.assertEqual(code, 1)
        self.assertIn("usage:", err)
        self.assertEqual(self.snapshot(), {})

    def test_agent_home_variables(self):
        alt = os.path.join(self.tmp, "alt")
        code, out, err = self.run_script(CLAUDE_CONFIG_DIR=os.path.join(alt, "claude"),
                                         CODEX_HOME=os.path.join(alt, "codex"),
                                         GEMINI_CLI_HOME=os.path.join(alt, "gemini"))
        self.assertEqual(code, 0, err)
        self.assertTrue(os.path.exists(os.path.join(alt, "claude", "settings.json")))
        self.assertTrue(os.path.exists(os.path.join(alt, "codex", "config.toml")))
        self.assertTrue(os.path.exists(os.path.join(alt, "gemini", ".gemini", ".env")))
        self.assertEqual(self.snapshot(), {})


class ExistingFiles(Base):
    def setUp(self):
        Base.setUp(self)
        self.claude_data = {
            "theme": "dark",
            "attribution": {"commit": ""},
            "env": {"FOO": "bar", "GIT_AUTHOR_EMAIL": "old@example.com"},
        }
        write(self.claude, json.dumps(self.claude_data, indent=2) + "\n")
        write(self.codex, CODEX_EXISTING)
        write(self.gemini, GEMINI_EXISTING)
        os.chmod(self.gemini, 0o640)
        self.original = self.snapshot()

    def test_updates_and_preserves(self):
        code, out, err = self.run_script()
        self.assertEqual(code, 0, err)

        data = json.loads(read(self.claude))
        self.assertEqual(list(data), ["theme", "attribution", "env"])
        self.assertEqual(data["attribution"], {"commit": ""})
        self.assertEqual(data["env"], dict(FOO="bar", **CLAUDE))
        self.assertIn("Břinda", read(self.claude))

        codex = read(self.codex)
        self.assertEqual(codex, CODEX_EXISTING.replace(
            'GIT_AUTHOR_NAME = "Somebody Else"\n',
            "\n".join(CODEX_LINES) + "\n"))
        self.assert_toml_valid(self.codex)

        gemini = read(self.gemini)
        self.assertTrue(gemini.startswith(
            "# Gemini secrets\nGEMINI_API_KEY=not-a-real-key\n"
            "export GIT_AUTHOR_NAME=\"Karel Břinda's Gemini\"\n"))
        for line in GEMINI_LINES[1:]:
            self.assertIn(line + "\n", gemini)
        self.assertEqual(os.stat(self.gemini).st_mode & 0o777, 0o640)

        self.assertIn("GIT_AUTHOR_EMAIL: old@example.com -> karel.brinda+claude@gmail.com", out)
        self.assertNotIn("not-a-real-key", out)

    def test_backups_hold_the_originals(self):
        self.run_script()
        backups = self.backups()
        self.assertEqual(len(backups), 3)
        for path in backups:
            self.assertEqual(read(path), self.original[re.sub(r"\.bak\.[0-9-]+$", "", path)])
        self.run_script()
        self.assertEqual(self.backups(), backups)

    def test_dry_run_writes_nothing(self):
        code, out, err = self.run_script("-n")
        self.assertEqual(code, 0, err)
        self.assertEqual(self.snapshot(), self.original)
        self.assertIn("would update: " + self.gemini, out)

    def test_invalid_file_aborts_everything(self):
        write(self.claude, '{"theme": "dark",}\n')
        before = self.snapshot()
        code, _, err = self.run_script()
        self.assertEqual(code, 1)
        self.assertIn("invalid JSON", err)
        self.assertEqual(self.snapshot(), before)

    def test_inline_codex_table_is_refused(self):
        write(self.codex, '[shell_environment_policy]\nset = { CI = "1" }\n')
        before = self.snapshot()
        code, _, err = self.run_script()
        self.assertEqual(code, 1)
        self.assertIn("inline table", err)
        self.assertEqual(self.snapshot(), before)

    def test_codex_policy_table_without_set(self):
        text = '[shell_environment_policy]\ninherit = "all"\n'
        write(self.codex, text)
        code, _, err = self.run_script("codex")
        self.assertEqual(code, 0, err)
        self.assertEqual(read(self.codex), text + "\n[shell_environment_policy.set]\n"
                         + "\n".join(CODEX_LINES) + "\n")

    def test_symlinked_config_stays_a_link(self):
        real = os.path.join(self.tmp, "dotfiles", "settings.json")
        write(real, read(self.claude))
        os.remove(self.claude)
        os.symlink(real, self.claude)
        code, _, err = self.run_script("claude")
        self.assertEqual(code, 0, err)
        self.assertTrue(os.path.islink(self.claude))
        self.assertEqual(json.loads(read(real))["env"]["GIT_AUTHOR_NAME"],
                         CLAUDE["GIT_AUTHOR_NAME"])


class GitUsesTheIdentity(Base):
    def test_commit_identity(self):
        if shutil.which("git") is None:
            self.skipTest("git not found")
        self.run_script("claude")
        repo = os.path.join(self.tmp, "repo")
        env = {k: v for k, v in os.environ.items() if not k.startswith("GIT_")}
        env.update(HOME=self.home, GIT_CONFIG_NOSYSTEM="1")
        env.update(json.loads(read(self.claude))["env"])
        run = lambda *a: subprocess.check_output(("git", "-C", repo) + a, env=env)
        subprocess.check_output(["git", "init", "-q", repo], env=env)
        run("commit", "-q", "--allow-empty", "-m", "test")
        log = run("log", "-1", "--format=%an <%ae>|%cn <%ce>").decode("utf-8").strip()
        ident = "Karel Břinda's Claude <karel.brinda+claude@gmail.com>"
        self.assertEqual(log, ident + "|" + ident)


if __name__ == "__main__":
    unittest.main()
