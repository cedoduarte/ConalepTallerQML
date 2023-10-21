#ifndef JUEGOUTIL_H
#define JUEGOUTIL_H

#include <QObject>

class JuegoUtil : public QObject
{
    Q_OBJECT
public:
    explicit JuegoUtil();
    virtual ~JuegoUtil();
    Q_INVOKABLE int getRandom(int a, int b) const;
};

#endif // JUEGOUTIL_H
