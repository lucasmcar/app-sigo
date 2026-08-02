{% include 'partials/navbar' %}

<div class="container-fluid mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>

            <h2 class="title mb-0">
                Clientes
            </h2>

            <p class="subtitle">
                Gerencie todos os clientes cadastrados.
            </p>

        </div>

        <a href="/sigo/cliente/cadastro"
           class="btn btn-primary">

            <i class="bi bi-person-plus-fill"></i>

            Novo Cliente

        </a>

    </div>

    <div class="card shadow-sm border-0">

        <div class="card-body">

            <div class="row mb-4">

                <div class="col-md-6">

                    <div class="input-group">

                        <span class="input-group-text">

                            <i class="bi bi-search"></i>

                        </span>

                        <input
                            type="text"
                            id="searchCustomer"
                            class="form-control"
                            placeholder="Buscar por nome, CPF ou CNPJ...">

                    </div>

                </div>

            </div>

            <div class="table-responsive">

                <table class="table table-hover align-middle">

                    <thead>

                        <tr>

                            <th>Cliente</th>

                            <th>Documento</th>

                            <th>Telefone</th>

                            <th class="text-center">Veículos</th>

                            <th>Cadastro</th>

                            <th>Atualização</th>

                            <th width="140">Ações</th>

                        </tr>

                    </thead>

                    <tbody id="customersTable">

                        <!-- Ajax -->

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>