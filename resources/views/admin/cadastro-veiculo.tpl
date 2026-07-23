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
                    Novo Veículo
                </h2>

                <p class="subtitle">
                    Localize o cliente e cadastre um novo veículo.
                </p>

            </div>

            <form class="vehicle-form" method="post" action="/sigo/veiculo/cadastrar">

                @csrf

                <div class="card border-0 bg-light mb-4">

                    <div class="card-body">

                        <h5 class="mb-3">
                            <i class="bi bi-person-circle"></i>
                            Cliente
                        </h5>

                        <div class="row">

                            <div class="col-md-8 mb-3">

                                <label class="form-label">
                                    CPF / CNPJ
                                </label>

                                <div class="input-group">

                                    <span class="input-group-text">
                                        <i class="bi bi-search"></i>
                                    </span>

                                    <input
                                        id="customer_document"
                                        name="document"
                                        class="form-control"
                                        placeholder="Digite o CPF ou CNPJ">

                                </div>

                                <div class="invalid-feedback"></div>

                            </div>

                            <div class="col-md-4 d-flex mb-3 align-items-end">

                                <button
                                    type="button"
                                    class="btn btn-primary w-100"
                                    id="btnSearchCustomer">

                                    <i class="bi bi-search"></i>

                                    Buscar Cliente

                                </button>

                            </div>

                        </div>

                        <div
                            id="customerCard"
                            class="border rounded p-3 bg-white mt-3 d-none">

                            <div class="row">

                                <div class="col-md-6">

                                    <strong>Cliente</strong>

                                    <p
                                        class="mb-2"
                                        id="customer_name">

                                        -

                                    </p>

                                </div>

                                <div class="col-md-3">

                                    <strong>Telefone</strong>

                                    <p
                                        class="mb-2"
                                        id="customer_phone">

                                        -

                                    </p>

                                </div>

                                <div class="col-md-3">

                                    <strong>E-mail</strong>

                                    <p
                                        class="mb-2"
                                        id="customer_email">

                                        -

                                    </p>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

                <!-- ========================= -->
                <!-- VEÍCULO -->
                <!-- ========================= -->

                <div
                    id="vehicleForm"
                    class="d-none">

                    <div class="row">

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Marca

                            </label>

                            <input
                                id="brand"
                                name="brand"
                                class="form-control">

                            <div class="invalid-feedback"></div>

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Modelo

                            </label>

                            <input
                                id="model"
                                name="model"
                                class="form-control">

                            <div class="invalid-feedback"></div>

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Versão

                            </label>

                            <input
                                id="version"
                                name="version"
                                class="form-control">

                        </div>

                        <div class="col-md-3 mb-3">

                            <label class="form-label">

                                Ano Fabricação

                            </label>

                            <input
                                id="manufacture_year"
                                name="manufacture_year"
                                class="form-control">

                        </div>

                        <div class="col-md-3 mb-3">

                            <label class="form-label">

                                Ano Modelo

                            </label>

                            <input
                                id="model_year"
                                name="model_year"
                                class="form-control">

                        </div>

                        <div class="col-md-3 mb-3">

                            <label class="form-label">

                                Placa

                            </label>

                            <input
                                id="plate"
                                name="plate"
                                class="form-control">

                            <div class="invalid-feedback"></div>

                        </div>

                        <div class="col-md-3 mb-3">

                            <label class="form-label">

                                Cor

                            </label>

                            <input
                                id="color"
                                name="color"
                                class="form-control">

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Chassi

                            </label>

                            <input
                                id="chassis"
                                name="chassis"
                                class="form-control">

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Renavam

                            </label>

                            <input
                                id="renavam"
                                name="renavam"
                                class="form-control">

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Quilometragem

                            </label>

                            <input
                                id="mileage"
                                name="mileage"
                                class="form-control">

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Combustível

                            </label>

                            <select
                                id="fuel"
                                name="fuel"
                                class="form-select">

                                <option value="">Selecione</option>

                                <option>Gasolina</option>
                                <option>Etanol</option>
                                <option>Flex</option>
                                <option>Diesel</option>
                                <option>GNV</option>
                                <option>Elétrico</option>
                                <option>Híbrido</option>

                            </select>

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Transmissão

                            </label>

                            <select
                                id="transmission"
                                name="transmission"
                                class="form-select">

                                <option value="">Selecione</option>

                                <option>Manual</option>

                                <option>Automático</option>

                                <option>CVT</option>

                            </select>

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Motorização

                            </label>

                            <input
                                id="engine"
                                name="engine"
                                class="form-control"
                                placeholder="1.0 / 1.6 / 2.0">

                        </div>

                        <div class="col-12">

                            <label class="form-label">

                                Observações

                            </label>

                            <textarea
                                id="notes"
                                name="notes"
                                rows="4"
                                class="form-control"
                                placeholder="Informações importantes sobre o veículo..."></textarea>

                        </div>

                    </div>
                    <input type="hidden" id="customer_id" name="customer_id">
                    <div class="d-grid gap-2 mt-4">

                        <button
                            id="submitBtn"
                            class="btn btn-primary">

                            <i class="bi bi-car-front-fill"></i>

                            Salvar Veículo

                        </button>

                        <a
                            href="/veiculos"
                            class="btn btn-outline-secondary">

                            Cancelar

                        </a>

                    </div>

                </div>

            </form>

        </div>

    </div>

</div>