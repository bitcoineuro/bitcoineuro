// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOINEURO_QT_BITCOINEUROADDRESSVALIDATOR_H
#define BITCOINEURO_QT_BITCOINEUROADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BitcoinEuroAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinEuroAddressEntryValidator(QObject* parent);

    State validate(QString& input, int& pos) const;
};

/** BitcoinEuro address widget validator, checks for a valid bitcoineuro address.
 */
class BitcoinEuroAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinEuroAddressCheckValidator(QObject* parent);

    State validate(QString& input, int& pos) const;
};

#endif // BITCOINEURO_QT_BITCOINEUROADDRESSVALIDATOR_H
