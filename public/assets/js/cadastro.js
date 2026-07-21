/* document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('.register-form');
    const registerFeedback = document.getElementById('registerFeedback');
    const csrfToken = document.querySelector('input[name="_csrf_token"]').value;

// Log do token CSRF para depuração
    if (!form || !registerFeedback) return;

    form.addEventListener('submit', async (e) => {
        e.preventDefault();

        // Exibe feedback de carregamento
        registerFeedback.textContent = 'Enviando...';
        registerFeedback.style.color = '#fff';
        registerFeedback.style.transition = 'opacity 0.3s ease';
        registerFeedback.style.opacity = '1';

        const formData = new FormData(form);
        formData.append('_csrf_token', csrfToken);

        try {
            const response = await fetch('/cadastrar', {
                method: 'POST',
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            });

            const result = await response.json();

            if (response.ok && result.success) {
  
                // Login bem-sucedido
                registerFeedback.textContent = result.message;
                registerFeedback.style.color = '#09c4e5';
                // Redireciona com base no campo 'redirect'
                setTimeout(() => {
                    window.location.href = result.redirect || '/sigo/dashboard';
                }, 1500); // Dá 1.5s para o usuário ver a mensagem
            } else {
                // Erro no login
                registerFeedback.textContent = result.message || 'E-mail ou senha inválidos.';
                registerFeedback.style.color = '#ff4d4d';
                // Redireciona para a página de login em caso de erro
                setTimeout(() => {
                    window.location.href = result.redirect || '/login';
                }, 1500);
            }
        } catch (error) {
            // Erro de conexão ou servidor
            registerFeedback.textContent = 'Erro ao conectar. Tente novamente.';
            registerFeedback.style.color = '#ff4d4d';
            console.error('Erro:', error);
            setTimeout(() => {
                window.location.href = '/login';
            }, 1500);
        }
    });
}); */
document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('.register-form');
    const submitBtn = document.getElementById('submitBtn');
    const csrfToken = document.querySelector('input[name="_csrf_token"]').value;

    const fields = {
        company_name: {
            el: document.getElementById('company_name'),
            validate: v => v.trim().length >= 3,
            message: 'Informe o nome da oficina.'
        },
        cnpj: {
            el: document.getElementById('cnpj'),
            validate: v => v.replace(/\\D/g, '').length === 14,
            message: 'CNPJ inválido.'
        },
        phone: {
            el: document.getElementById('phone'),
            validate: v => v.replace(/\\D/g, '').length >= 10,
            message: 'Telefone inválido.'
        },
        email: {
            el: document.getElementById('email'),
            validate: v => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v),
            message: 'E-mail inválido.'
        },
        username: {
            el: document.getElementById('username'),
            validate: v => v.trim().length >= 3,
            message: 'Informe o responsável.'
        },
        password: {
            el: document.getElementById('password'),
            validate: v => v.length >= 6,
            message: 'A senha deve ter ao menos 6 caracteres.'
        }
    };

    const password2 = document.getElementById('password2');

    function setInvalid(input, message) {

        input.classList.remove('is-valid');
        input.classList.add('is-invalid');

        const feedback = input.closest('.mb-3').querySelector('.invalid-feedback');

        if (feedback) {
            feedback.textContent = message;
        }

    }

    function setValid(input) {
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');

        const feedback = input.closest('.mb-3').querySelector('.invalid-feedback');

        if (feedback) {
            feedback.textContent = '';
        }
    }

    function validateField(key) {
        const field = fields[key];
        const value = field.el.value;

        if (!field.validate(value)) {
            setInvalid(field.el, field.message);
            return false;
        }

        setValid(field.el);
        return true;
    }

    function validatePasswords() {
        if (password2.value.length === 0) {
            password2.classList.remove('is-valid', 'is-invalid');
            return false;
        }

        if (fields.password.el.value !== password2.value) {
            setInvalid(password2, 'As senhas não coincidem.');
            return false;
        }

        setValid(password2);
        return true;
    }

    function validateForm() {
        let valid = true;

        Object.keys(fields).forEach(key => {
            if (!validateField(key)) valid = false;
        });

        if (!validatePasswords()) valid = false;

        submitBtn.disabled = !valid;
        return valid;
    }

    Object.keys(fields).forEach(key => {
        fields[key].el.addEventListener('input', validateForm);
    });

    password2.addEventListener('input', validateForm);

    form.addEventListener('submit', async (e) => {
        e.preventDefault();

        if (!validateForm()) return;

        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Cadastrando...';

        try {
            const formData = new FormData(form);
            formData.append('_csrf_token', csrfToken);

            const response = await fetch('/cadastrar', {
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
                    title: 'Cadastro realizado!',
                    text: result.message,
                    confirmButtonText: 'Ir para o login',
                    confirmButtonColor: '#0d6efd',
                    allowOutsideClick: false
                });

                window.location.href = result.redirect || '/login';
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Erro ao cadastrar',
                    text: result.message || 'Verifique os dados informados.',
                    confirmButtonColor: '#dc3545'
                });
            }

        } catch (error) {
            console.error(error);

            Swal.fire({
                icon: 'error',
                title: 'Erro de conexão',
                text: 'Não foi possível conectar ao servidor.',
                confirmButtonColor: '#dc3545'
            });
        } finally {
            submitBtn.disabled = false;
            submitBtn.innerHTML = '<i class="bi bi-person-plus-fill"></i> Criar minha conta';
        }
    });
});