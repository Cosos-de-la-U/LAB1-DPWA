<%@ page import="main.Pistas.GuessNumber" %>
<%@ include file="common/header.jspf" %>
<%@ include file="common/navigation.jspf" %>

<body>
    <div class="container mt-4">

        <%
            GuessNumber game = GuessNumber.getInstance();
            int numeroAdivinar = GuessNumber.getNumber();
        %>
        <div class="d-flex justify-content-center">
            <h2>Adivinar el numero</h2>
        </div>

        <!-- Start answer and guess -->
        <div class="d-flex justify-content-center">
            <div class="row">
                <div class="col-12">
                    <p class="text-center">
                        <c:if test="${param.enviar != null && intentos != 0}">
                            <%
                                int number = Integer.parseInt(request.getParameter("number"));
                                String msg = game.checkGame(number);
                            %>
                            <%=msg%>
                        </c:if>
                    </p>
                </div>
                <div class="col-12">
                    <p class="text-center h3">
                            <%
                                int intentos = GuessNumber.getTries();

                                session.setAttribute("intentos", intentos);
                            %>
                            Intentos Disponibles: <%=intentos%>
                    </p>
                </div>
                <div class="col-12">
                    <!--p class="text-center h2"><%//=numeroAdivinar%></p-->
                </div>
                <div class="col-12">
                    <p class="text-center h3">
                        <c:if test="${intentos == 0 || param.rendirse != null}">
                            <%
                                game.surrender();
                                intentos = GuessNumber.getTries();

                                session.setAttribute("intentos", intentos);
                            %>
                            Numero a adivinar era <%=numeroAdivinar%>
                        </c:if>
                    </p>
                </div>
            </div>
        </div>
        <!-- End answer and guess -->

        <div class="d-flex justify-content-center">
            <form action="index.jsp" method="post">
                <div class="d-flex flex-column">
                    <div class="form-group col-12">
                        <input type="number" class="form-control" name="number" placeholder="Ingrese numero..." min="0" data-bind="value:replyNumber" required/>
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <button type="submit" name="enviar" class="btn btn-primary w-100">Enviar</button>
                        </div>
                        <div class="col-4">
                            <button type="submit" name="reiniciar" class="btn btn-danger w-100">Reiniciar</button>
                        </div>
                        <div class="col-4">
                            <button type="submit" name="rendirse" class="btn btn-warning w-100">Rendirse</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <c:if test="${param.reiniciar != null}">
            <%
                game.resetAll();
                response.setIntHeader("Refresh", 0);
            %>
        </c:if>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    </div>
</body>