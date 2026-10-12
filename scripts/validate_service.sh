#!/bin/bash
for i in {1..10}; do
  if curl -fs http://localhost/ | grep -q "Nonexistent"; then
    echo "Validation passed"
    exit 0
  fi
  sleep 3
done
echo "Validation failed: site is not serving the GlobalMart page" >&2
exit 1
