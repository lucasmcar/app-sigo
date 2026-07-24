document.addEventListener('DOMContentLoaded', () => {

    const search = document.getElementById('searchCustomer');
    const table = document.getElementById('customersTable');

    let timeout = null;

    loadCustomers();

    search.addEventListener('keyup', () => {

        clearTimeout(timeout);

        timeout = setTimeout(() => {

            loadCustomers(search.value);

        },300);

    });

    async function loadCustomers(term=''){

        table.innerHTML=`
            <tr>
                <td colspan="7" class="text-center py-5">

                    <div class="spinner-border text-primary"></div>

                    <br>

                    <small class="text-muted">

                        Carregando...

                    </small>

                </td>
            </tr>
        `;

        try{

            const response = await fetch('/sigo/cliente/listar?search='+encodeURIComponent(term),{

                headers:{
                    'X-Requested-With':'XMLHttpRequest',
                    
                }

            });

            const result = await response.json();

            renderTable(result);

        }catch(e){

            console.error(e);

            table.innerHTML=`
                <tr>

                    <td colspan="7" class="text-center text-danger">

                        Não foi possível carregar os clientes.

                    </td>

                </tr>
            `;

        }

    }

    function renderTable(customers){

        if(customers.length===0){

            table.innerHTML=`
                <tr>

                    <td colspan="7" class="text-center py-5">

                        <i class="bi bi-search fs-2"></i>

                        <br>

                        Nenhum cliente encontrado.

                    </td>

                </tr>
            `;

            return;

        }

        let html='';

        customers.forEach(customer=>{

            html+=`

                <tr>

                    <td>

                        <strong>${customer.name}</strong>

                        <br>

                        <small class="text-muted">

                            ${customer.email ?? ''}

                        </small>

                    </td>

                    <td>

                        ${customer.cpf ?? customer.cnpj}

                    </td>

                    <td>

                        ${customer.phone ?? ''}

                    </td>

                    <td class="text-center">

                        <span class="badge bg-primary">

                            ${customer.vehicles}

                        </span>

                    </td>

                    <td>

                        ${formatDate(customer.created_at)}

                    </td>

                    <td>

                        ${formatDate(customer.updated_at)}

                    </td>

                    <td>

                        <a
                            href="/sigo/clientes/editar/${customer.id}"
                            class="btn btn-sm btn-outline-primary">

                            <i class="bi bi-pencil"></i>

                        </a>

                        <button
                            class="btn btn-sm btn-outline-danger btnDelete"
                            data-id="${customer.id}"
                            data-name="${customer.name}">

                            <i class="bi bi-trash"></i>

                        </button>

                    </td>

                </tr>

            `;

        });

        table.innerHTML=html;

        bindDeleteButtons();

    }

    function bindDeleteButtons(){

        document.querySelectorAll('.btnDelete').forEach(button=>{

            button.addEventListener('click',()=>{

                Swal.fire({

                    icon:'warning',

                    title:'Excluir cliente?',

                    text:'Esta ação não poderá ser desfeita.',

                    showCancelButton:true,

                    confirmButtonText:'Excluir',

                    cancelButtonText:'Cancelar',

                    confirmButtonColor:'#dc3545'

                }).then(async(result)=>{

                    if(!result.isConfirmed)
                        return;

                    try{

                        const response=await fetch('/sigo/clientes/excluir/'+button.dataset.id,{

                            method:'DELETE',

                            headers:{
                                'X-Requested-With':'XMLHttpRequest'
                            }

                        });

                        const json=await response.json();

                        if(json.success){

                            Swal.fire({

                                icon:'success',

                                title:'Cliente excluído',

                                timer:1200,

                                showConfirmButton:false

                            });

                            loadCustomers(search.value);

                        }else{

                            Swal.fire({

                                icon:'error',

                                title:'Erro',

                                text:json.message

                            });

                        }

                    }catch(e){

                        Swal.fire({

                            icon:'error',

                            title:'Erro',

                            text:'Erro ao excluir cliente.'

                        });

                    }

                });

            });

        });

    }

    function formatDate(date){

        if(!date)
            return '-';

        return new Date(date).toLocaleDateString('pt-BR');

    }

});