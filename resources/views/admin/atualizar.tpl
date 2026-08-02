{% include 'partials/navbar' %}
<div class="container-fluid mt-4">

    <div class="card register-card mx-auto">

        <div class="card-body">

            <div class="text-center mb-4">

                <h2 class="title">
                    Minha Oficina
                </h2>

                <p class="subtitle">
                    Atualize as informações de contato e acesso da sua oficina.
                </p>

            </div>

            <form class="edit-form" method="POST" action="/cadastro/atualizar">

                @csrf

                <div class="alert alert-info">

                    <i class="bi bi-info-circle-fill"></i>

                    Apenas <strong>Telefone</strong>, <strong>E-mail</strong> e
                    <strong>Senha</strong> podem ser alterados.

                </div>

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
                                type="text"
                                class="form-control bg-light"
                                value="{{ $company_name }}"
                                readonly>

                        </div>

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
                                type="text"
                                class="form-control bg-light"
                                value="{{ $cnpj }}"
                                readonly>

                        </div>

                    </div>

                    <!-- Responsável -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Responsável
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-person"></i>
                            </span>

                            <input
                                type="text"
                                class="form-control bg-light"
                                value="{{ $user }}"
                                readonly>

                        </div>

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
                                value="{{ $phone }}">

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Email -->
                    <div class="col-md-6 mb-3">

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
                                value="{{ $email }}">

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <hr class="my-3">

                    <div class="col-12 mb-3">

                        <h5 class="text-primary">

                            <i class="bi bi-shield-lock"></i>

                            Alteração de Senha

                        </h5>

                        <small class="text-muted">
                            Caso não deseje alterar sua senha, deixe os campos abaixo em branco.
                        </small>

                    </div>

                    <!-- Nova Senha -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Nova Senha
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

                    <!-- Confirmar -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">
                            Confirmar Nova Senha
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

                <div class="d-grid gap-2 mt-4">

                    <button
                        id="submitBtn"
                        class="btn btn-primary">

                        <i class="bi bi-check-circle-fill"></i>

                        Salvar Alterações

                    </button>

                    <a
                        href="/sigo/dashboard"
                        class="btn btn-outline-secondary">

                        <i class="bi bi-arrow-left"></i>

                        Voltar ao Dashboard

                    </a>

                </div>

                <div
                    id="registerFeedback"
                    class="feedback mt-3">

                </div>

                <div class="footer mt-4">

                    SIGO © 2026

                </div>

            </form>

        </div>

    </div>

</div>

<script>

function togglePassword(id, eye){

    let input = document.getElementById(id);
    let icon = document.getElementById(eye);

    if(input.type === "password"){

        input.type = "text";
        icon.className = "bi bi-eye-slash";

    }else{

        input.type = "password";
        icon.className = "bi bi-eye";

    }

}

</script>