#include "juegoutil.h"

#include <QRandomGenerator>

JuegoUtil::JuegoUtil()
{
}

JuegoUtil::~JuegoUtil()
{
}

int JuegoUtil::getRandom(int a, int b) const
{
    return QRandomGenerator::global()->bounded(a, b);
}
