package main.Banco;

public class BankAccount {

    private String Nombre;
    private String Cuenta;
    private double Saldo;
    private TypeOfInterest TipoDeInteres;
    private double Tiempo;


    public BankAccount(String nombre, String cuenta, double saldo, TypeOfInterest tipoDeInteres, double tiempo) {
        Nombre = nombre;
        Cuenta = cuenta;
        TipoDeInteres = tipoDeInteres;
        Tiempo = tiempo;
        Saldo = cacularInteresSimple(saldo);
    }

    //transaction
    public void transaccion(String transaccionselecionada, double cantidad) {
        if (transaccionselecionada.equals("1")) {
            retiros(cantidad);
        }

        if (transaccionselecionada.equals("2")) {
            depositos(cantidad);
        }
    }

    //Name
    public String obtenerNombre() {
        return Nombre;
    }

    public void asignarNombre(String nombre) {
        Nombre = nombre;
    }

    //Account
    public String obtenerCuenta() {
        return Cuenta;
    }

    public void asignarCuenta(String cuenta) {
        Cuenta = cuenta;
    }

    public void EstadodeCuenta(String cuenta) {
        Cuenta = cuenta;
    }

    //Balance
    public double obtenerSaldo() {
        return Saldo;
    }

    public void asignarSaldo(double saldo) {
        Saldo = saldo;
    }

    public double cacularInteresSimple(double saldo) {
        return saldo + (saldo * this.TipoDeInteres.getPerCal() * this.Tiempo );
    }

    //Kind of interest
    public TypeOfInterest obtenerTipoDeInteres() {
        return TipoDeInteres;
    }

    public void asignarInteres(TypeOfInterest tipoDeInteres) {
        TipoDeInteres = tipoDeInteres;
    }

    public TypeOfInterest obtenerInteres() {
        return TipoDeInteres;
    }

    //Transaction Stuff
    public void depositos(double cantidad) {
        Saldo += cantidad;
        }

    public void retiros(double cantidad) {
        if(Saldo >= cantidad){
            Saldo -= cantidad;
        }
    }

}
