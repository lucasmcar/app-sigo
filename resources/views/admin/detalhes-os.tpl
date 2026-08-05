{% include 'partials/navbar' %}
<div class="container py-4">

    <!-- Cabeçalho -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>
            <h2 class="fw-bold mb-0">
                Ordem de Serviço #{{ $service_order['number'] }}
            </h2>

            <small class="text-muted">
                Criada em {{ $service_order['entry_date'] }}
            </small>
        </div>

        <div class="d-flex gap-2">

            <a href="/sigo/os" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i>
                Voltar
            </a>

            <a href="/sigo/os/{{ $service_order['id'] }}/editar" class="btn btn-primary">
                <i class="bi bi-pencil-square"></i>
                Editar
            </a>

        </div>

    </div>

    <div class="row">

        <!-- Dados da OS -->
        <div class="col-lg-8">

            <div class="card shadow-sm border-0 mb-4">

                <div class="card-header bg-white">

                    <h5 class="mb-0">
                        Dados da Ordem de Serviço
                    </h5>

                </div>

                <div class="card-body">

                    <div class="row g-3">

                        <div class="col-md-4">

                            <label class="form-label text-muted">
                                Número
                            </label>

                            <input
                                type="text"
                                class="form-control"
                                value="{{ $service_order['number'] }}"
                                readonly>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label text-muted">
                                Status
                            </label>

                            <input
                                type="text"
                                class="form-control"
                                value="{{ $service_order['status'] }}"
                                readonly>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label text-muted">
                                Tipo de Serviço
                            </label>

                            <input
                                type="text"
                                class="form-control"
                                value="{{ $service_order['service_type'] }}"
                                readonly>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label text-muted">
                                Entrada
                            </label>

                            <input
                                type="text"
                                class="form-control"
                                value="{{ $service_order['entry_date'] }}"
                                readonly>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label text-muted">
                                Previsão
                            </label>

                            <input
                                type="text"
                                class="form-control"
                                value="{{ $service_order['expected_date'] }}"
                                readonly>

                        </div>

                        <div class="col-md-4">

                            <label class="form-label text-muted">
                                Quilometragem
                            </label>

                            <input
                                type="text"
                                class="form-control"
                                value="{{ $service_order['mileage'] }}"
                                readonly>

                        </div>

                        <div class="col-md-12">

                            <label class="form-label text-muted">
                                Queixa do Cliente
                            </label>

                            <textarea
                                rows="4"
                                class="form-control"
                                readonly>{{ $service_order['complaint'] }}</textarea>

                        </div>

                        <div class="col-md-12">

                            <label class="form-label text-muted">
                                Diagnóstico
                            </label>

                            <textarea
                                rows="4"
                                class="form-control"
                                readonly>{{ $service_order['diagnosis'] }}</textarea>

                        </div>

                        <div class="col-md-12">

                            <label class="form-label text-muted">
                                Observações
                            </label>

                            <textarea
                                rows="4"
                                class="form-control"
                                readonly>{{ $service_order['observations'] }}</textarea>

                        </div>

                    </div>

                </div>

            </div>

            <!-- Serviços -->
            <div class="card shadow-sm border-0 mb-4">

                <div class="card-header bg-white d-flex justify-content-between align-items-center">

                    <h5 class="mb-0">
                        Serviços
                    </h5>

                    <button
                        class="btn btn-sm btn-primary"
                        id="btnAddService">

                        <i class="bi bi-plus-circle"></i>

                        Adicionar Serviço

                    </button>

                </div>

                <div class="card-body p-0">

                    <table class="table table-hover align-middle mb-0">

                        <thead class="table-light">

                            <tr>

                                <th>Descrição</th>

                                <th width="120">Qtd.</th>

                                <th width="150">Valor</th>

                                <th width="80"></th>

                            </tr>

                        </thead>

                        <tbody id="serviceTable">

                            <tr>

                                <td colspan="4" class="text-center text-muted py-4">

                                    Nenhum serviço cadastrado.

                                </td>

                            </tr>

                        </tbody>

                    </table>

                </div>

            </div>

            <!-- Peças -->
            <div class="card shadow-sm border-0">

                <div class="card-header bg-white d-flex justify-content-between align-items-center">

                    <h5 class="mb-0">
                        Peças
                    </h5>

                    <button
                        class="btn btn-sm btn-primary"
                        id="btnAddPart">

                        <i class="bi bi-plus-circle"></i>

                        Adicionar Peça

                    </button>

                </div>

                <div class="card-body p-0">

                    <table class="table table-hover align-middle mb-0">

                        <thead class="table-light">

                            <tr>

                                <th>Peça</th>

                                <th width="120">Qtd.</th>

                                <th width="150">Valor</th>

                                <th width="80"></th>

                            </tr>

                        </thead>

                        <tbody id="partsTable">

                            <tr>

                                <td colspan="4" class="text-center text-muted py-4">

                                    Nenhuma peça cadastrada.

                                </td>

                            </tr>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">

            <!-- Cliente -->
            <div class="card shadow-sm border-0 mb-4">

                <div class="card-header bg-white">

                    <h5 class="mb-0">

                        Cliente

                    </h5>

                </div>

                <div class="card-body">

                    <p class="mb-1">
                        <strong>{{ $service_order['customer']['name'] }}</strong>
                    </p>

                    <p class="text-muted mb-1">
                        {{ $service_order['customer']['document'] }}
                    </p>

                    <p class="text-muted mb-1">
                        {{ $service_order['customer']['phone'] }}
                    </p>

                    <p class="text-muted mb-0">
                        {{ $service_order['customer']['email'] }}
                    </p>

                </div>

            </div>

            <!-- Veículo -->
            <div class="card shadow-sm border-0 mb-4">

                <div class="card-header bg-white">

                    <h5 class="mb-0">

                        Veículo

                    </h5>

                </div>

                <div class="card-body">

                    <p class="mb-1">

                        <strong>{{ $service_order['vehicle']['brand'] }} {{ $service_order['vehicle']['model'] }}</strong>

                    </p>

                    <p class="text-muted mb-1">

                        Placa: {{ $service_order['vehicle']['plate'] }}

                    </p>

                    <p class="text-muted mb-1">

                        Ano: {{ $service_order['vehicle']['model_year'] }}

                    </p>

                    <p class="text-muted mb-0">

                        Cor: {{ $service_order['vehicle']['color'] }}

                    </p>

                </div>

            </div>

            <!-- Financeiro -->
            <div class="card shadow-sm border-0">

                <div class="card-header bg-white">

                    <h5 class="mb-0">

                        Resumo Financeiro

                    </h5>

                </div>

                <div class="card-body">

                    <div class="d-flex justify-content-between mb-2">

                        <span>Serviços</span>

                        <strong>R$ {{ $service_order['os']['service_total'] }}</strong>

                    </div>

                    <div class="d-flex justify-content-between mb-2">

                        <span>Peças</span>

                        <strong>R$ {{ $service_order['os']['parts_total'] }}</strong>

                    </div>

                    <hr>

                    <div class="d-flex justify-content-between">

                        <h5>Total</h5>

                        <h5 class="text-primary">

                            R$ {{ $service_order['os']['total_value'] }}

                        </h5>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>