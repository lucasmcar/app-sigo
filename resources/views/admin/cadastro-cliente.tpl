<nav class="navbar navbar-expand-lg navbar-dark shadow">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <i class="bi bi-tools"></i>
      SIGO
    </a>

    <button
      class="navbar-toggler"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#menu"
    >
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="menu">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active" href="/sigo/dashboard">Dashboard</a>
        </li>

        <li class="nav-item dropdown">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            role="button"
            data-bs-toggle="dropdown"
          >
            Cadastros
          </a>

          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/sigo/cadastro/atualizar">Editar cadastro</a></li>
            <li><a class="dropdown-item" href="/sigo/cliente/cadastro">Clientes</a></li>
            <li><a class="dropdown-item" href="#">Veículos</a></li>
            <li><a class="dropdown-item" href="#">Serviços</a></li>
            <li><a class="dropdown-item" href="#">Funcionários</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            role="button"
            data-bs-toggle="dropdown"
          >
            Ordens de Serviço
          </a>

          <ul class="dropdown-menu">
            <li><a class="dropdown-item">Nova Ordem</a></li>

            <li><a class="dropdown-item">Em andamento</a></li>

            <li><a class="dropdown-item">Finalizadas</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            data-bs-toggle="dropdown"
          >
            Financeiro
          </a>

          <ul class="dropdown-menu">
            <li><a class="dropdown-item">Receitas</a></li>

            <li><a class="dropdown-item">Despesas</a></li>

            <li><a class="dropdown-item">Fluxo de Caixa</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            data-bs-toggle="dropdown"
          >
            Estoque
          </a>

          <ul class="dropdown-menu">
            <li><a class="dropdown-item">Produtos</a></li>

            <li><a class="dropdown-item">Movimentações</a></li>
          </ul>
        </li>
      </ul>

      <div class="text-white">
        <i class="bi bi-bell me-3"></i>

        <i class="bi bi-person-circle"></i>

        Oficina Otto
      </div>
    </div>
  </div>
</nav>

<div class="container-fluid mt-4">

    <div class="card register-card mx-auto">

        <div class="card-body">

            <div class="text-center mb-4">

                <h2 class="title">

                    Novo Cliente

                </h2>

                <p class="subtitle">

                    Cadastre um cliente da sua oficina.

                </p>

            </div>

            <form class="customer-form" method="POST" action="/sigo/cliente/cadastrar">

                @csrf

                <div class="row">

                    <!-- Nome -->

                    <div class="col-md-8 mb-3">

                        <label class="form-label">

                            Nome Completo

                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-person"></i>
                            </span>

                            <input
                                id="name"
                                type="text"
                                class="form-control"
                                name="name"
                                placeholder="Nome do cliente">

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Tipo -->

                    <div class="col-md-4 mb-3">

                        <label class="form-label">

                            Tipo de Pessoa

                        </label>

                        <select
                            id="person_type"
                            class="form-select"
                            name="person_type">

                            <option value="F">Pessoa Física</option>

                            <option value="J">Pessoa Jurídica</option>

                        </select>

                    </div>

                    <!-- CPF -->

                    <div class="col-md-6 mb-3" id="cpfGroup">

                        <label class="form-label">

                            CPF

                        </label>

                        <div class="input-group">

                            <span class="input-group-text">

                                <i class="bi bi-person-vcard"></i>

                            </span>

                            <input
                                id="cpf"
                                type="text"
                                class="form-control"
                                name="cpf"
                                placeholder="000.000.000-00">

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- CNPJ -->

                    <div class="col-md-6 mb-3 d-none" id="cnpjGroup">

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

                    <!-- Data Nascimento -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Data de Nascimento

                        </label>

                        <input
                            id="birth_date"
                            type="date"
                            class="form-control"
                            name="birth_date">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Telefone -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            Telefone

                        </label>

                        <input
                            id="phone"
                            type="text"
                            class="form-control"
                            name="phone"
                            placeholder="(51) 3333-3333">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- WhatsApp -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label">

                            WhatsApp

                        </label>

                        <input
                            id="whatsapp"
                            type="text"
                            class="form-control"
                            name="whatsapp"
                            placeholder="(51) 99999-9999">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Email -->

                    <div class="col-md-12 mb-3">

                        <label class="form-label">

                            E-mail

                        </label>

                        <input
                            id="email"
                            type="email"
                            class="form-control"
                            name="email"
                            placeholder="cliente@email.com">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- CEP -->

                    <div class="col-md-3 mb-3">

                        <label class="form-label">

                            CEP

                        </label>

                        <input
                            id="cep"
                            type="text"
                            class="form-control"
                            name="cep"
                            placeholder="00000-000">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Rua -->

                    <div class="col-md-7 mb-3">

                        <label class="form-label">

                            Rua

                        </label>

                        <input
                            id="street"
                            type="text"
                            class="form-control"
                            name="street">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Número -->

                    <div class="col-md-2 mb-3">

                        <label class="form-label">

                            Número

                        </label>

                        <input
                            id="number"
                            type="text"
                            class="form-control"
                            name="number">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Complemento -->

                    <div class="col-md-4 mb-3">

                        <label class="form-label">

                            Complemento

                        </label>

                        <input
                            id="complement"
                            type="text"
                            class="form-control"
                            name="complement">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Bairro -->

                    <div class="col-md-4 mb-3">

                        <label class="form-label">

                            Bairro

                        </label>

                        <input
                            id="district"
                            type="text"
                            class="form-control"
                            name="district">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Cidade -->

                    <div class="col-md-3 mb-3">

                        <label class="form-label">

                            Cidade

                        </label>

                        <input
                            id="city"
                            type="text"
                            class="form-control"
                            name="city">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- UF -->

                    <div class="col-md-1 mb-3">

                        <label class="form-label">

                            UF

                        </label>

                        <input
                            id="state"
                            maxlength="2"
                            class="form-control"
                            name="state">

                        <div class="invalid-feedback"></div>

                    </div>

                    <!-- Observações -->

                    <div class="col-12 mb-3">

                        <label class="form-label">

                            Observações

                        </label>

                        <textarea
                            id="notes"
                            rows="4"
                            class="form-control"
                            name="notes"
                            placeholder="Observações sobre o cliente..."></textarea>

                    </div>

                </div>
                <input type="hidden" name="company_id" value="{{ $company_id }}">

                <div class="d-grid gap-2 mt-4">

                    <button
                        id="submitBtn"
                        type="submit"
                        class="btn btn-primary">

                        <i class="bi bi-check-circle-fill"></i>

                        Salvar Cliente

                    </button>

                    <a
                        href="/clientes"
                        class="btn btn-outline-secondary">

                        Cancelar

                    </a>

                </div>

            </form>

        </div>

    </div>

</div>