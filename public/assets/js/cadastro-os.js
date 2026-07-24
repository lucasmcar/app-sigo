document.addEventListener('DOMContentLoaded', () => {

    const form = document.querySelector('.service-order-form');
    const submitBtn = document.getElementById('submitBtn');
    const csrfToken = document.querySelector('input[name="_csrf_token"]').value;

    const btnSearchVehicle = document.getElementById('btnSearchVehicle');
    const plate = document.getElementById('plate');

    const vehicleId = document.getElementById('vehicle_id');

    const vehicleCard = document.getElementById('vehicleCard');
    const osForm = document.getElementById('osForm');

    const fields = {

        plate: {
            el: plate,
            validate: v => /^[A-Z]{3}[0-9][A-Z0-9][0-9]{2}$/.test(
                v.replace('-', '').toUpperCase()
            ),
            message: 'Informe uma placa válida.'
        },

        complaint: {
            el: document.getElementById('complaint'),
            validate: v => v.trim().length >= 5,
            message: 'Descreva a reclamação.'
        },

        entry_mileage: {
            el: document.getElementById('entry_mileage'),
            validate: v => Number(v) >= 0,
            message: 'Informe a quilometragem.'
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
                valid = false;

        });

        submitBtn.disabled = !valid;

        return valid;

    }

    Object.keys(fields).forEach(key=>{

        fields[key].el.addEventListener('input', validateForm);

    });

    plate.addEventListener('input',function(){

        let value=this.value.toUpperCase();

        value=value.replace(/[^A-Z0-9]/g,'');

        if(value.length>3){

            value=value.substring(0,3)+'-'+value.substring(3);

        }

        this.value=value;

    });

    btnSearchVehicle.addEventListener('click', async ()=>{

        let vehiclePlate = plate.value.replace('-','').toUpperCase();

        if(vehiclePlate.length !== 7){

            Swal.fire({

                icon:'warning',
                title:'Placa inválida',
                text:'Informe uma placa válida.'

            });

            return;

        }

        try{

            const formData = new FormData();

            formData.append('plate', vehiclePlate);
            formData.append('_csrf_token', csrfToken);

            const response = await fetch('/sigo/veiculos/buscar',{

                method:'POST',

                body:formData,

                headers:{
                    'X-Requested-With':'XMLHttpRequest',
                    'X-CSRF-TOKEN': csrfToken
                }

            });

            const result = await response.json();

            if(result.success){

                vehicleCard.classList.remove('d-none');
                osForm.classList.remove('d-none');

                vehicleId.value = result.data.id;

                document.getElementById('customer_name').textContent = result.data.customer_name;
                document.getElementById('vehicle_model').textContent = result.data.brand + ' ' + result.data.model;
                document.getElementById('vehicle_year').textContent = result.data.model_year;
                document.getElementById('vehicle_color').textContent = result.data.color;
                document.getElementById('vehicle_plate').textContent = result.data.plate;
                document.getElementById('entry_mileage').value = result.data.mileage;
            }else{

                vehicleCard.classList.add('d-none');
                osForm.classList.add('d-none');

                Swal.fire({

                    icon:'warning',
                    title:'Veículo não encontrado',
                    text:result.message

                });

            }

        }catch(e){

            console.error(e);

            Swal.fire({

                icon:'error',
                title:'Erro',
                text:'Não foi possível localizar o veículo.'

            });

        }

    });

    form.addEventListener('submit', async(e)=>{

        e.preventDefault();

        if(!validateForm())
            return;

        submitBtn.disabled = true;

        submitBtn.innerHTML =
            '<span class="spinner-border spinner-border-sm me-2"></span>Salvando...';

        try{

            const formData = new FormData(form);
            
            formData.append('_csrf_token', csrfToken);

            const response = await fetch('/sigo/os/cadastrar',{

                method:'POST',

                body:formData,

                headers:{
                    'X-Requested-With':'XMLHttpRequest',
                    'X-CSRF-TOKEN': csrfToken
                }

            });

            const result = await response.json();

            if(result.success){

                await Swal.fire({

                    icon:'success',
                    title:'Ordem de Serviço criada!',
                    text:result.message,
                    confirmButtonColor:'#0d6efd'

                });

                window.location.href = result.redirect || '/os';

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

            submitBtn.disabled = false;

            submitBtn.innerHTML =
                '<i class="bi bi-check-circle-fill"></i> Abrir Ordem de Serviço';

        }

    });

});