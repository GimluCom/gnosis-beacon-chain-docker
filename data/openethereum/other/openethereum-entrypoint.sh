#!/bin/bash
for DNS_PROVIDER in "@resolver4.opendns.com myip.opendns.com" "@ns1-1.akamaitech.net ANY whoami.akamai.net" "@ns1.google.com TXT o-o.myaddr.l.google.com"
do
  EXT_IP=$(dig $DNS_PROVIDER +short)
  if [[ $EXT_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    break
  fi
done
sh /bin/openethereum --nat="extip:$EXT_IP" "$@"
