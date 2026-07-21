<div class="container">
    <div class="card register-card mx-auto">

        <div class="card-body">

            <div class="text-center mb-4">
                <h2 class="title">Criar Conta</h2>

                <p class="subtitle">
                    Cadastre sua oficina e comece a utilizar o SIGO.
                </p>
            </div>

            <form class="register-form" method="POST" action="/cadastrar">

                @csrf

                <div class="row">

                    <!-- Nome da Oficina -->
                    <div class="col-md-12 mb-3">

                        <label class="form-label">
                            Nome da Oficina
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-shop"></i>
                            </span>

                            <input
                                id="company_name"
                                type="text"
                                class="form-control"
                                name="company_name"
                                placeholder="Ex.: Oficina do João">

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- CNPJ -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            CNPJ
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-building"></i>
                            </span>

                            <input
                                id="cnpj"
                                type="text"
                                class="form-control"
                                name="cnpj"
                                placeholder="00.000.000/0000-00">

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Telefone -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Telefone / WhatsApp
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-telephone"></i>
                            </span>

                            <input
                                id="phone"
                                type="text"
                                class="form-control"
                                name="phone"
                                placeholder="(51) 99999-9999">

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Email -->
                    <div class="col-md-12 mb-3">

                        <label class="form-label">
                            E-mail
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-envelope"></i>
                            </span>

                            <input
                                id="email"
                                type="email"
                                class="form-control"
                                name="email"
                                placeholder="contato@oficina.com.br">

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Responsável -->
                    <div class="col-md-12 mb-3">

                        <label class="form-label">
                            Responsável
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-person"></i>
                            </span>

                            <input
                                id="username"
                                type="text"
                                class="form-control"
                                name="username"
                                placeholder="Nome do responsável">

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Senha -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Senha
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-lock"></i>
                            </span>

                            <input
                                id="password"
                                type="password"
                                class="form-control"
                                name="password">

                            <span
                                class="input-group-text password-toggle"
                                onclick="togglePassword('password','eye1')">

                                <i class="bi bi-eye" id="eye1"></i>

                            </span>

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Confirmar Senha -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Confirmar Senha
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-lock-fill"></i>
                            </span>

                            <input
                                id="password2"
                                type="password"
                                class="form-control"
                                name="password_confirmation">

                            <span
                                class="input-group-text password-toggle"
                                onclick="togglePassword('password2','eye2')">

                                <i class="bi bi-eye" id="eye2"></i>

                            </span>

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                </div>

                <div class="form-check mb-4">

                    <input
                        class="form-check-input"
                        type="checkbox"
                        id="terms">

                    <label
                        class="form-check-label"
                        for="terms">

                        Li e concordo com os Termos de Uso e Política de Privacidade.

                    </label>

                </div>

                <button
                    class="btn btn-primary w-100 btn-register"
                    id="submitBtn"
                    disabled>

                    <i class="bi bi-person-plus-fill"></i>

                    Criar minha conta

                </button>

                <div class="feedback mt-3" id="registerFeedback"></div>

                <div class="text-center mt-4">

                    <span class="text-muted">
                        Já possui uma conta?
                    </span>

                    <a
                        href="/login"
                        class="text-decoration-none fw-semibold">

                        Entrar

                    </a>

                </div>

                <div class="footer">SIGO © {% year %}</div>

            </form>

        </div>

    </div>
</div>

<script>

function togglePassword(id, eye){

    const input = document.getElementById(id);
    const icon = document.getElementById(eye);

    if(input.type === "password"){
        input.type = "text";
        icon.className = "bi bi-eye-slash";
    }else{
        input.type = "password";
        icon.className = "bi bi-eye";
    }

}

</script>