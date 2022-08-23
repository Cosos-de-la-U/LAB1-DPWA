package main.Banco;

public enum TypeOfInterest {
    Bajo("1%",1),
    Normal("2.5%",2.50),
    Alto("5%",5);

    private final String per;
    private final double perCal;

    TypeOfInterest(String per, double perCal) {
        this.per = per;
        this.perCal = perCal;
    }

    public String getPer() {
        return per;
    }

    public double getPerCal() {
        return perCal;
    }
}
