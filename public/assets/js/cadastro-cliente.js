document.addEventListener('DOMContentLoaded', () => {

    const form = document.querySelector('.customer-form');
    const submitBtn = document.getElementById('submitBtn');

    if (!form) return;

    const csrfToken = document.querySelector('input[name="_csrf_token"]').value;

    const personType = document.getElementById('person_type');

    const cpfGroup = document.getElementById('cpfGroup');
    const cnpjGroup = document.getElementById('cnpjGroup');

    const fields = {

        name: {

            el: document.getElementById('name'),

            validate: value => value.trim().length >= 3,

            message: 'Informe o nome do cliente.'

        },

        cpf: {

            el: document.getElementById('cpf'),

            validate: value => {

                if (personType.value !== 'F')
                    return true;

                return value.replace(/\D/g, '').length === 11;

            },

            message: 'CPF inválido.'

        },

        cnpj: {

            el: document.getElementById('cnpj'),

            validate: value => {

                if (personType.value !== 'J')
                    return true;

                return value.replace(/\D/g, '').length === 14;

            },

            message: 'CNPJ inválido.'

        },

        phone: {

            el: document.getElementById('phone'),

            validate: value => {

                if (value.trim() === '')
                    return true;

                return value.replace(/\D/g, '').length >= 10;

            },

            message: 'Telefone inválido.'

        },

        whatsapp: {

            el: document.getElementById('whatsapp'),

            validate: value => {

                if (value.trim() === '')
                    return true;

                return value.replace(/\D/g, '').length >= 10;

            },

            message: 'WhatsApp inválido.'

        },

        email: {

            el: document.getElementById('email'),

            validate: value => {

                if (value.trim() === '')
                    return true;

                return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);

            },

            message: 'E-mail inválido.'

        },

        cep: {

            el: document.getElementById('cep'),

            validate: value => {

                if (value.trim() === '')
                    return true;

                return value.replace(/\D/g, '').length === 8;

            },

            message: 'CEP inválido.'

        }

    };

    /*
    |--------------------------------------------------------------------------
    | Feedback Bootstrap
    |--------------------------------------------------------------------------
    */

    function setInvalid(input, message) {

        input.classList.remove('is-valid');
        input.classList.add('is-invalid');

        const feedback = input
            .closest('.mb-3')
            .querySelector('.invalid-feedback');

        if (feedback)
            feedback.textContent = message;

    }

    function setValid(input) {

        input.classList.remove('is-invalid');
        input.classList.add('is-valid');

        const feedback = input
            .closest('.mb-3')
            .querySelector('.invalid-feedback');

        if (feedback)
            feedback.textContent = '';

    }

    function clearValidation(input) {

        input.classList.remove('is-valid');
        input.classList.remove('is-invalid');

        const feedback = input
            .closest('.mb-3')
            .querySelector('.invalid-feedback');

        if (feedback)
            feedback.textContent = '';

    }

    /*
    |--------------------------------------------------------------------------
    | Alterna Pessoa Física / Jurídica
    |--------------------------------------------------------------------------
    */

    function togglePersonType() {

        if (personType.value === 'F') {

            cpfGroup.classList.remove('d-none');
            cnpjGroup.classList.add('d-none');

            fields.cnpj.el.value = '';
            clearValidation(fields.cnpj.el);

        } else {

            cpfGroup.classList.add('d-none');
            cnpjGroup.classList.remove('d-none');

            fields.cpf.el.value = '';
            clearValidation(fields.cpf.el);

        }

    }

    personType.addEventListener('change', togglePersonType);

    togglePersonType();

    /*
    |--------------------------------------------------------------------------
    | Máscaras
    |--------------------------------------------------------------------------
    */

    function onlyNumbers(value) {

        return value.replace(/\D/g, '');

    }

    function maskCPF(value) {

        value = onlyNumbers(value);

        value = value.replace(/^(\d{3})(\d)/, '$1.$2');
        value = value.replace(/^(\d{3})\.(\d{3})(\d)/, '$1.$2.$3');
        value = value.replace(/\.(\d{3})(\d)/, '.$1-$2');

        return value.substring(0, 14);

    }

    function maskCNPJ(value) {

        value = onlyNumbers(value);

        value = value.replace(/^(\d{2})(\d)/, '$1.$2');
        value = value.replace(/^(\d{2})\.(\d{3})(\d)/, '$1.$2.$3');
        value = value.replace(/\.(\d{3})(\d)/, '.$1/$2');
        value = value.replace(/(\d{4})(\d)/, '$1-$2');

        return value.substring(0, 18);

    }

    function maskPhone(value) {

        value = onlyNumbers(value);

        if (value.length <= 10) {

            value = value.replace(/^(\d{2})(\d)/, '($1) $2');
            value = value.replace(/(\d{4})(\d)/, '$1-$2');

        } else {

            value = value.replace(/^(\d{2})(\d)/, '($1) $2');
            value = value.replace(/(\d{5})(\d)/, '$1-$2');

        }

        return value.substring(0, 15);

    }

    function maskCEP(value) {

        value = onlyNumbers(value);

        value = value.replace(/^(\d{5})(\d)/, '$1-$2');

        return value.substring(0, 9);

    }

    fields.cpf.el.addEventListener('input', e => {

        e.target.value = maskCPF(e.target.value);

    });

    fields.cnpj.el.addEventListener('input', e => {

        e.target.value = maskCNPJ(e.target.value);

    });

    fields.phone.el.addEventListener('input', e => {

        e.target.value = maskPhone(e.target.value);

    });

    fields.whatsapp.el.addEventListener('input', e => {

        e.target.value = maskPhone(e.target.value);

    });

    fields.cep.el.addEventListener('input', e => {

        e.target.value = maskCEP(e.target.value);

    });

        /*
    |--------------------------------------------------------------------------
    | Consulta CEP (ViaCEP)
    |--------------------------------------------------------------------------
    */

    async function searchCEP() {

        const cep = fields.cep.el.value.replace(/\D/g, '');

        if (cep.length !== 8)
            return;

        try {

            const response = await fetch(`https://viacep.com.br/ws/${cep}/json/`);

            const data = await response.json();

            if (data.erro) {

                setInvalid(fields.cep.el, 'CEP não encontrado.');
                return;

            }

            document.getElementById('street').value = data.logradouro || '';
            document.getElementById('district').value = data.bairro || '';
            document.getElementById('city').value = data.localidade || '';
            document.getElementById('state').value = data.uf || '';

            setValid(fields.cep.el);

        } catch (e) {

            console.error(e);

        }

    }

    fields.cep.el.addEventListener('blur', searchCEP);

    /*
    |--------------------------------------------------------------------------
    | Validação individual
    |--------------------------------------------------------------------------
    */

    function validateField(key) {

        const field = fields[key];

        if (!field)
            return true;

        const value = field.el.value;

        if (!field.validate(value)) {

            setInvalid(field.el, field.message);

            return false;

        }

        if (value.trim() === '') {

            clearValidation(field.el);

        } else {

            setValid(field.el);

        }

        return true;

    }

    /*
    |--------------------------------------------------------------------------
    | Validação geral
    |--------------------------------------------------------------------------
    */

    function validateForm() {

        let valid = true;

        Object.keys(fields).forEach(key => {

            if (!validateField(key))
                valid = false;

        });

        if (personType.value === 'F') {

            if (fields.cpf.el.value.trim() === '') {

                setInvalid(fields.cpf.el, 'Informe o CPF.');

                valid = false;

            }

        }

        if (personType.value === 'J') {

            if (fields.cnpj.el.value.trim() === '') {

                setInvalid(fields.cnpj.el, 'Informe o CNPJ.');

                valid = false;

            }

        }

        submitBtn.disabled = !valid;

        return valid;

    }

    /*
    |--------------------------------------------------------------------------
    | Eventos
    |--------------------------------------------------------------------------
    */

    Object.keys(fields).forEach(key => {

        fields[key].el.addEventListener('input', validateForm);

    });

    /*
    |--------------------------------------------------------------------------
    | Submit
    |--------------------------------------------------------------------------
    */

    form.addEventListener('submit', async function (e) {

        e.preventDefault();

        if (!validateForm())
            return;

        submitBtn.disabled = true;

        submitBtn.innerHTML = `
            <span class="spinner-border spinner-border-sm me-2"></span>
            Salvando...
        `;

        try {

            const formData = new FormData(form);

            formData.append('_csrf_token', csrfToken);

            const response = await fetch('/clientes/cadastrar', {

                method: 'POST',

                body: formData,

                headers: {

                    'X-Requested-With': 'XMLHttpRequest'

                }

            });

            const result = await response.json();

            if (result.success) {

                await Swal.fire({

                    icon: 'success',

                    title: 'Cliente cadastrado!',

                    text: result.message,

                    confirmButtonColor: '#0d6efd',

                    confirmButtonText: 'Continuar'

                });

                window.location.href = result.redirect || '/clientes';

            } else {

                Swal.fire({

                    icon: 'error',

                    title: 'Erro',

                    text: result.message,

                    confirmButtonColor: '#dc3545'

                });

            }

        } catch (error) {

            console.error(error);

            Swal.fire({

                icon: 'error',

                title: 'Erro de conexão',

                text: 'Não foi possível comunicar com o servidor.',

                confirmButtonColor: '#dc3545'

            });

        } finally {

            submitBtn.disabled = false;

            submitBtn.innerHTML = `
                <i class="bi bi-check-circle-fill"></i>
                Salvar Cliente
            `;

        }

    });

});
