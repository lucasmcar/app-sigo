<div class="container">

    <div class="card login-card mx-auto">

        <div class="logo">
            <i class="bi bi-tools"></i>
        </div>

        <div class="card-body">

            <div class="text-center mb-4">

                <h2 class="title">SIGO</h2>

                <p class="subtitle">
                    Sistema Integrado de Gerenciamento de Oficinas
                </p>

            </div>

            <form class="login-form" method="POST" action="/login">

                @csrf

                <div class="mb-3">
                    <label class="form-label">
                        Usuário
                    </label>

                    <div class="input-group">

                        <span class="input-group-text">
                            <i class="bi bi-person"></i>
                        </span>

                        <input
                            type="text"
                            class="form-control"
                            name="username"
                            placeholder="Digite seu usuário"
                            autofocus>

                    </div>

                </div>

                <div class="mb-4">

                    <label class="form-label">
                        Senha
                    </label>

                    <div class="input-group">

                        <span class="input-group-text">
                            <i class="bi bi-lock"></i>
                        </span>

                        <input
                            type="password"
                            class="form-control"
                            id="password"
                            name="password"
                            placeholder="Digite sua senha">

                        <span class="input-group-text password-toggle"
                              onclick="togglePassword()">

                            <i class="bi bi-eye" id="eye"></i>

                        </span>

                    </div>

                </div>

                <button class="btn btn-primary w-100 btn-login">
                    <i class="bi bi-box-arrow-in-right"></i>
                    Entrar
                </button>
                <div class="feedback" id="loginFeedback"></div>

                <div class="text-center mt-4">
                    <span class="text-muted">Ainda não possui uma conta?</span>
                    <a href="/cadastro" class="text-decoration-none fw-semibold">
                        Cadastre-se
                    </a>
                </div>

            </form>

            <div class="footer">
                SIGO © {% year %}
            </div>

        </div>

    </div>

</div>

<script>

function togglePassword(){

    let password = document.getElementById("password");
    let eye = document.getElementById("eye");

    if(password.type === "password"){

        password.type = "text";
        eye.className = "bi bi-eye-slash";

    }else{

        password.type = "password";
        eye.className = "bi bi-eye";

    }

}

</script>

</body>
</html>