#!/bin/bash
set -e
if ! rpm -q httpd >/dev/null 2>&1; then
  dnf install -y httpd
fi
systemctl enable httpd
