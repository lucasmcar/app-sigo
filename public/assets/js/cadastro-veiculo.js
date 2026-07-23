document.addEventListener('DOMContentLoaded', () => {

    const form = document.querySelector('.vehicle-form');
    const submitBtn = document.getElementById('submitBtn');
    const csrfToken = document.querySelector('input[name="_csrf_token"]').value;

    const btnSearch = document.getElementById('btnSearchCustomer');
    const customerDocument = document.getElementById('customer_document');

    const customerCard = document.getElementById('customerCard');
    const vehicleForm = document.getElementById('vehicleForm');

    // hidden que você adicionará na tela
    const customerId = document.getElementById('customer_id');

    const fields = {

        brand: {
            el: document.getElementById('brand'),
            validate: v => v.trim().length > 1,
            message: 'Informe a marca.'
        },

        model: {
            el: document.getElementById('model'),
            validate: v => v.trim().length > 1,
            message: 'Informe o modelo.'
        },

        plate: {
            el: document.getElementById('plate'),
            validate: v => {

                v = v.toUpperCase();

                return /^[A-Z]{3}[0-9][A-Z0-9][0-9]{2}$/.test(
                    v.replace(/-/g, '')
                );

            },
            message: 'Placa inválida.'
        },

        manufacture_year: {
            el: document.getElementById('manufacture_year'),
            validate: v => /^\d{4}$/.test(v),
            message: 'Ano inválido.'
        },

        model_year: {
            el: document.getElementById('model_year'),
            validate: v => /^\d{4}$/.test(v),
            message: 'Ano inválido.'
        }

    };

    function setInvalid(input, message){

        input.classList.remove('is-valid');
        input.classList.add('is-invalid');

        const feedback = input
            .closest('.mb-3')
            .querySelector('.invalid-feedback');

        if(feedback)
            feedback.textContent = message;

    }

    function setValid(input){

        input.classList.remove('is-invalid');
        input.classList.add('is-valid');

        const feedback = input
            .closest('.mb-3')
            .querySelector('.invalid-feedback');

        if(feedback)
            feedback.textContent='';

    }

    function validateField(key){

        const field = fields[key];

        if(!field.validate(field.el.value)){

            setInvalid(field.el, field.message);

            return false;

        }

        setValid(field.el);

        return true;

    }

    function validateForm(){

        let valid = true;

        Object.keys(fields).forEach(key=>{

            if(!validateField(key))
                valid=false;

        });

        submitBtn.disabled=!valid;

        return valid;

    }

    Object.keys(fields).forEach(key=>{

        fields[key].el.addEventListener('input',validateForm);

    });


    customerDocument.addEventListener('input', function(){

        let value=this.value.replace(/\D/g,'');

        if(value.length<=11){

            value=value.replace(/(\d{3})(\d)/,'$1.$2');
            value=value.replace(/(\d{3})(\d)/,'$1.$2');
            value=value.replace(/(\d{3})(\d{1,2})$/,'$1-$2');

        }else{

            value=value.replace(/^(\d{2})(\d)/,'$1.$2');
            value=value.replace(/^(\d{2})\.(\d{3})(\d)/,'$1.$2.$3');
            value=value.replace(/\.(\d{3})(\d)/,'.$1/$2');
            value=value.replace(/(\d{4})(\d)/,'$1-$2');

        }

        this.value=value;

    });

    fields.plate.el.addEventListener('input',function(){

        let value=this.value.toUpperCase();

        value=value.replace(/[^A-Z0-9]/g,'');

        if(value.length>3){

            value=value.substring(0,3)+'-'+value.substring(3);

        }

        this.value=value;

    });



    btnSearch.addEventListener('click', async () => {

        const documentNumber = customerDocument.value.replace(/\D/g, '');

        if (documentNumber.length !== 11 && documentNumber.length !== 14) {

            Swal.fire({
                icon: 'warning',
                title: 'Documento inválido',
                text: 'Informe um CPF ou CNPJ válido.'
            });

            return;
        }

        try {

            const formData = new FormData();

            formData.append('document', documentNumber);
            formData.append('_csrf_token', csrfToken);

            const response = await fetch('/sigo/clientes/buscar', {
                method: 'POST',
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'X-CSRF-TOKEN': csrfToken
                }
            });

            const result = await response.json();

            if (result.success) {

                customerCard.classList.remove('d-none');
                vehicleForm.classList.remove('d-none');

                customerId.value = result.customer.id;

                document.getElementById('customer_name').textContent = result.customer.name;
                document.getElementById('customer_phone').textContent = result.customer.phone;
                document.getElementById('customer_email').textContent = result.customer.email;

            } else {

                customerCard.classList.add('d-none');
                vehicleForm.classList.add('d-none');

                Swal.fire({
                    icon: 'warning',
                    title: 'Cliente não encontrado',
                    text: result.message,
                    showCancelButton: true,
                    confirmButtonText: 'Cadastrar Cliente',
                    cancelButtonText: 'Cancelar'
                }).then((r) => {

                    if (r.isConfirmed) {
                        window.location.href = '/sigo/cliente/cadastro';
                    }

                });

            }

        } catch (e) {

            console.error(e);

            Swal.fire({
                icon: 'error',
                title: 'Erro',
                text: 'Não foi possível localizar o cliente.'
            });

        }

    });

  
    form.addEventListener('submit',async(e)=>{

        e.preventDefault();

        if(!validateForm())
            return;

        submitBtn.disabled=true;

        submitBtn.innerHTML=
            '<span class="spinner-border spinner-border-sm me-2"></span>Salvando...';

        try{

            const formData=new FormData(form);
            formData.append('_csrf_token', csrfToken);

            const response=await fetch('/sigo/veiculo/cadastrar',{

                method:'POST',

                body:formData,

                headers:{
                    'X-Requested-With':'XMLHttpRequest',
                    'X-CSRF-TOKEN': csrfToken
                }

            });

            const result=await response.json();

            if(result.success){

                await Swal.fire({

                    icon:'success',

                    title:'Veículo cadastrado!',

                    text:result.message,

                    confirmButtonColor:'#0d6efd'

                });

                window.location.href=result.redirect || '/veiculos';

            }else{

                Swal.fire({

                    icon:'error',

                    title:'Erro',

                    text:result.message

                });

            }

        }catch(e){

            console.error(e);

            Swal.fire({

                icon:'error',

                title:'Erro',

                text:'Falha ao comunicar com o servidor.'

            });

        }finally{

            submitBtn.disabled=false;

            submitBtn.innerHTML='<i class="bi bi-car-front-fill"></i> Salvar Veículo';

        }

    });

});