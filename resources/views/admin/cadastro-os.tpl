{% include 'partials/navbar' %}
<div class="container-fluid mt-4">

     <div class="card register-card mx-auto">

        <div class="card-body">

            <div class="text-center mb-4">

                <h2 class="title">
                    Nova Ordem de Serviço
                </h2>

                <p class="subtitle">
                    Localize um veículo para iniciar a Ordem de Serviço.
                </p>

            </div>

            <form class="service-order-form">

                @csrf

                <input
                    type="hidden"
                    id="vehicle_id"
                    name="vehicle_id">

                <!-- BUSCA -->

                <div class="row">

                    <div class="col-md-10 mb-3">

                        <label class="form-label">
                            Placa do Veículo
                        </label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="bi bi-car-front-fill"></i>
                            </span>

                            <input
                                type="text"
                                class="form-control"
                                id="plate"
                                name="plate"
                                maxlength="8"
                                placeholder="ABC-1234 ou BRA2E19">

                        </div>

                        <div class="invalid-feedback"></div>

                    </div>

                    <div class="col-md-2 d-grid mb-3">

                        <label class="form-label">&nbsp;</label>

                        <button
                            type="button"
                            class="btn btn-primary"
                            id="btnSearchVehicle">

                            <i class="bi bi-search"></i>

                            Buscar

                        </button>

                    </div>

                </div>

                <!-- CARD VEÍCULO -->

                <div
                    class="card border-primary mb-4 d-none"
                    id="vehicleCard">

                    <div class="card-header">

                        <strong>

                            Veículo localizado

                        </strong>

                    </div>

                    <div class="card-body">

                        <div class="row">

                            <div class="col-md-6 mb-2">

                                <small class="text-muted">

                                    Cliente

                                </small>

                                <div id="customer_name"></div>

                            </div>

                            <div class="col-md-3 mb-2">

                                <small class="text-muted">

                                    Modelo

                                </small>

                                <div id="vehicle_model"></div>

                            </div>

                            <div class="col-md-3 mb-2">

                                <small class="text-muted">

                                    Ano

                                </small>

                                <div id="vehicle_year"></div>

                            </div>

                            <div class="col-md-3">

                                <small class="text-muted">

                                    Cor

                                </small>

                                <div id="vehicle_color"></div>

                            </div>

                            <div class="col-md-3">

                                <small class="text-muted">

                                    Placa

                                </small>

                                <div id="vehicle_plate"></div>

                            </div>

                        </div>

                    </div>

                </div>

                <!-- FORMULÁRIO -->

                <div
                    id="osForm"
                    class="d-none">

                    <div class="row">

                        <div class="col-md-12 mb-3">

                            <label class="form-label">

                                Reclamação do Cliente

                            </label>

                            <textarea
                                id="complaint"
                                name="complaint"
                                rows="4"
                                class="form-control"
                                placeholder="Descreva o problema informado pelo cliente"></textarea>

                            <div class="invalid-feedback"></div>

                        </div>


                        <div class="col-md-6 mb-3">
    <label class="form-label">
        Categoria do Atendimento
    </label>

    <select
        id="service_category"
        name="service_category"
        class="form-select">

        <option value="mecanica">Mecânica</option>

        <option value="funilaria">Funilaria</option>

        <option value="pintura">Pintura</option>

        <option value="funilaria_pintura">
            Funilaria + Pintura
        </option>

        <option value="eletrica">Elétrica</option>

        <option value="estetica">
            Estética Automotiva
        </option>

        <option value="ar_condicionado">
            Ar Condicionado
        </option>

        <option value="revisao">
            Revisão
        </option>

        <option value="outro">
            Outro
        </option>

    </select>

</div>


<div class="col-md-3 mb-3">

<label class="form-label">

Prioridade

</label>

<select
id="priority"
name="priority"
class="form-select">

<option value="normal">Normal</option>

<option value="alta">Alta</option>

<option value="urgente">Urgente</option>

</select>

</div>





                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Quilometragem de Entrada

                            </label>

                            <div class="input-group">

                                <span class="input-group-text">

                                    <i class="bi bi-speedometer2"></i>

                                </span>

                                <input
                                    type="number"
                                    class="form-control"
                                    id="entry_mileage"
                                    name="entry_mileage"
                                    placeholder="0">

                            </div>

                            <div class="invalid-feedback"></div>

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Previsão de Entrega

                            </label>

                            <input
                                type="date"
                                class="form-control"
                                id="estimated_delivery"
                                name="estimated_delivery">

                        </div>

                        <div class="col-md-4 mb-3">

                            <label class="form-label">

                                Status Inicial

                            </label>

                            <select
                                class="form-select"
                                id="status"
                                name="status">

                                <option value="ABERTA">

                                    Aberta

                                </option>

                                <option value="EM_ANALISE">

                                    Em análise

                                </option>

                            </select>

                        </div>

                        <div class="col-md-12 mb-3">

                            <label class="form-label">

                                Observações

                            </label>

                            <textarea
                                rows="4"
                                class="form-control"
                                id="notes"
                                name="notes"
                                placeholder="Observações internas (opcional)"></textarea>

                        </div>

                    </div>

                    <div class="col-md-3 mb-3">

<label class="form-label">

Valor Estimado

</label>

<div class="input-group">

<span class="input-group-text">
R$
</span>

<input
type="number"
step="0.01"
class="form-control"
id="estimated_value"
name="estimated_value">

</div>

</div>

                    <div class="d-grid gap-2 mt-4">

                        <button
                            id="submitBtn"
                            class="btn btn-primary">

                            <i class="bi bi-check-circle-fill"></i>

                            Abrir Ordem de Serviço

                        </button>

                        <a
                            href="/os"
                            class="btn btn-outline-secondary">

                            Cancelar

                        </a>

                    </div>

                </div>

            </form>

        </div>

    </div>

</div>