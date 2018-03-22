#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BITCOINEUROD=${BITCOINEUROD:-$SRCDIR/bitcoineurod}
BITCOINEUROCLI=${BITCOINEUROCLI:-$SRCDIR/bitcoineuro-cli}
BITCOINEUROTX=${BITCOINEUROTX:-$SRCDIR/bitcoineuro-tx}
BITCOINEUROQT=${BITCOINEUROQT:-$SRCDIR/qt/bitcoineuro-qt}

[ ! -x $BITCOINEUROD ] && echo "$BITCOINEUROD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BCEVER=($($BITCOINEUROCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for bitcoineurod if --version-string is not set,
# but has different outcomes for bitcoineuro-qt and bitcoineuro-cli.
echo "[COPYRIGHT]" > footer.h2m
$BITCOINEUROD --version | sed -n '1!p' >> footer.h2m

for cmd in $BITCOINEUROD $BITCOINEUROCLI $BITCOINEUROTX $BITCOINEUROQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BCEVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BCEVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
