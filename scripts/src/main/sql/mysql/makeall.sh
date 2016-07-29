#!/bin/sh

cat "000 Framework/001 - iframe.sql" > mc-all.sql
cat "000 Framework/002 - itrust.sql" >> mc-all.sql
cat "000 Framework/003 - ischeduler.sql" >> mc-all.sql
cat "100 mc-ebook-server/101 - mc-ebook-server.sql" >> mc-all.sql
cat "400 - mc-ebook-eam/401 - mc-ebook-eam.sql" >> mc-all.sql

