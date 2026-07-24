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
          <a class="nav-link active" href="#">Dashboard</a>
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
            <li><a class="dropdown-item" href="/sigo/cliente/cadastro">Cadastro Clientes</a></li>
            <li><a class="dropdown-item" href="/sigo/veiculo/cadastro">Cadastro Veículos</a></li>
            <li><a class="dropdown-item" href="/sigo/clientes/todos">Clientes</a></li>
            <li><a class="dropdown-item" href="/sigo/os/cadastro">Serviços</a></li>
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
  <div class="mb-4">
    <h3>Olá, Oficina Otto</h3>

    <p class="text-muted">Resumo da oficina nesta {{ $atual }} </p>
  </div>

  <div class="row g-4">
    <div class="col-md-3">
      <div class="card kpi">
        <div class="card-body">
          <h6>Ordens Hoje</h6>

          <h2>18</h2>

          <span class="text-success"> +4% </span>
        </div>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card kpi">
        <div class="card-body">
          <h6>Em Pintura</h6>

          <h2>7</h2>
        </div>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card kpi">
        <div class="card-body">
          <h6>Faturamento</h6>

          <h2>R$ 48.750</h2>
        </div>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card kpi">
        <div class="card-body">
          <h6>Clientes</h6>

          <h2>426</h2>
        </div>
      </div>
    </div>
  </div>

  <div class="row mt-4">
    <div class="col-lg-8">
      <div class="card">
        <div class="card-header bg-white">Faturamento dos últimos meses</div>

        <div class="card-body">
          <canvas id="grafico"></canvas>
        </div>
      </div>
    </div>

    <div class="col-lg-4">
      <div class="card">
        <div class="card-header bg-white">Agenda de Hoje</div>

        <div class="card-body">
          08:00 - Pintura Corolla
          <hr />

          10:00 - Polimento Civic
          <hr />

          14:00 - Funilaria Toro
          <hr />

          16:00 - Entrega HB20
        </div>
      </div>
    </div>
  </div>

  <div class="row mt-4">
    <div class="col-lg-8">
      <div class="card">
        <div class="card-header bg-white">Últimas Ordens de Serviço</div>

        <div class="table-responsive">
          <table class="table table-hover">
            <thead>
              <tr>
                <th>Nº</th>

                <th>Cliente</th>

                <th>Veículo</th>

                <th>Status</th>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td>1032</td>

                <td>Carlos</td>

                <td>Corolla</td>

                <td><span class="badge bg-warning">Pintura</span></td>
              </tr>

              <tr>
                <td>1033</td>

                <td>Ana</td>

                <td>HB20</td>

                <td><span class="badge bg-info">Preparação</span></td>
              </tr>

              <tr>
                <td>1034</td>

                <td>Pedro</td>

                <td>Toro</td>

                <td><span class="badge bg-success">Finalizada</span></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div class="col-lg-4">
      <div class="card">
        <div class="card-header bg-white">Estoque Baixo</div>

        <div class="card-body">
          <ul class="list-group list-group-flush">
            <li class="list-group-item">
              Primer PU

              <span class="badge bg-danger float-end"> 2 </span>
            </li>

            <li class="list-group-item">
              Lixa 1200

              <span class="badge bg-danger float-end"> 3 </span>
            </li>

            <li class="list-group-item">
              Verniz

              <span class="badge bg-danger float-end"> 1 </span>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
  new Chart(document.getElementById("grafico"), {
    type: "bar",

    data: {
      labels: ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun"],

      datasets: [
        {
          label: "Faturamento",

          data: [22000, 28000, 26000, 35000, 42000, 48750],

          borderRadius: 10,
        },
      ],
    },

    options: {
      plugins: {
        legend: {
          display: false,
        },
      },
    },
  });
</script>
