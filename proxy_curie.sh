#! /usr/bin/env bash

export http_proxy="www-cache:3128"
export https_proxy="www-cache:3128"

exec socat STDIO PROXY:www-cache:$1:$2,proxyport=3128

