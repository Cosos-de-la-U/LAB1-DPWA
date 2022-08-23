<%@ page import="main.Banco.BankAccount" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="main.Banco.TypeOfInterest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/header.jspf" %>
<%@ include file="common/navigation.jspf" %>

<body>
    <div class="container mt-4">
        <div class="row">
            <!-- Start of info of the account -->
            <div class="col-6">
                <h3>Crear cuenta</h3>
                <form action="banco.jsp" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" name="nombre" id="nombre" placeholder="Ingrese nombre... " required>
                    </div>
                    <div class="form-group">
                        <input type="number" class="form-control" name="cuenta" id="cuenta" placeholder="Ingrese cuenta... " required>
                    </div>
                    <div class="form-group">
                        <input type="number" class="form-control" name="saldo" id="saldo" placeholder="Ingrese saldo... " required>
                    </div>
                    <div class="form-group">
                        <input type="number" class="form-control" name="tiempo" id="tiempo" placeholder="Ingrese años de la cuenta... " required>
                    </div>
                    <div class="form-group">
                        <label for="interes">Seleccione el interes</label>
                        <select class="form-control" name="interes">
                            <!-- For loop of the ENUM-->
                            <% for (TypeOfInterest interest: TypeOfInterest.values()){ %>
                                <option value="<%=interest%>"><%=interest%> - <%=interest.getPer()%></option>
                            <% } %>
                            <!-- For loop of the ENUM-->
                        </select>
                    </div>
                    <button type="submit" name="crear" class="btn btn-primary">Crear</button>
                </form>
            </div>
            <!-- End of info of the account -->

            <c:if test="${param.crear != null}">
                <%
                    BankAccount cuenta = new BankAccount(
                            request.getParameter("nombre"),
                            request.getParameter("cuenta"),
                            Double.parseDouble(request.getParameter("saldo")),
                            TypeOfInterest.valueOf(request.getParameter("interes")),
                            Double.parseDouble(request.getParameter("tiempo"))
                    );

                    // Verifying if ListaCuenta already exists
                    if(session.getAttribute("ListaCuentas") != null){
                        List<BankAccount> ListaCuentas = (List<BankAccount>) session.getAttribute("ListaCuentas");
                        ListaCuentas.add(cuenta);

                        session.setAttribute("ListaCuentas", ListaCuentas);
                    }else{
                        List<BankAccount> ListaCuentas = new ArrayList<BankAccount>();
                        ListaCuentas.add(cuenta);

                        session.setAttribute("ListaCuentas", ListaCuentas);
                    }
                %>

            </c:if>

            <!-- Start of the transaccion -->
            <div class="col-6">
                <h3>Hacer transaccion</h3>
                <form action="banco.jsp" method="post">
                    <div class="form-group">
                        <label for="cuentaSeleccionar">Seleccione la cuenta</label>
                        <select class="form-control" name="cuentaSeleccionar">

                            <!-- Fill the select -->
                            <c:if test="${param.crear != null || param.procesar != null}">
                                <%
                                    List<BankAccount> ListaCuentas = (List<BankAccount>) session.getAttribute("ListaCuentas");

                                    session.setAttribute("ListaCuentas", ListaCuentas);
                                %>
                                <c:forEach var = "i" begin = "0" end = "${ListaCuentas.size()-1}">
                                    <option class="form-control" value="${ListaCuentas[i].obtenerCuenta()}">${ListaCuentas[i].obtenerCuenta()}</option>
                                </c:forEach>
                            </c:if>
                            <!-- Fill the select -->

                        </select>
                    </div>
                    <div class="form-group">
                        <label for="transaccion">Seleccione transaccion
                        </label>
                        <select class="form-control" name="transaccion">
                            <option value="1" selected>Retiro</option>
                            <option value="2">Deposito</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="number" class="form-control" name="monto" placeholder="Ingrese el monto... " value="0">
                    </div>
                    <button type="submit" name="procesar" class="btn btn-primary">Procesar</button>
                </form>
            </div>
            <!-- End of info of the transaccion -->
        </div>

        <!-- Start of info of the transaccion -->
        <c:if test="${param.procesar != null}">
            <%
                List<BankAccount> ListaCuentas = (List<BankAccount>) session.getAttribute("ListaCuentas");

                String cuentaSelecionada = request.getParameter("cuentaSeleccionar");

                BankAccount cliente = null;

                //Find the account
                for(int x = 0; ListaCuentas.size() > 0; x++ ){
                    if(ListaCuentas.get(x).obtenerCuenta().equals(cuentaSelecionada)){
                        cliente = ListaCuentas.get(x);
                        break;
                    }
                }
            %>
            <div>
                <div class="card text-center">
                    <div class="card-header">
                        Usuario: <%=cliente.obtenerNombre()%> - Cuenta: <%=cliente.obtenerCuenta()%>
                    </div>
                    <div class="card-body">
                        <p class="card-text">Monto ingresado: ${param.monto}</p>
                        <p class="card-text">Saldo anterior: <%=cliente.obtenerSaldo()%></p>
                        <%
                            //Transaccion
                            cliente.transaccion(
                                    request.getParameter("transaccion"),
                                    Double.parseDouble(request.getParameter("monto"))
                            );
                        %>
                        <p class="card-text">Saldo total: <%=cliente.obtenerSaldo()%></p>
                        <p class="card-text">Tipo de interes: <%=cliente.obtenerTipoDeInteres()%> - <%=cliente.obtenerTipoDeInteres().getPer()%></p>
                    </div>
                </div>
            </div>
        </c:if>
        <!-- End of info of the transaccion -->

    </div>
</body>