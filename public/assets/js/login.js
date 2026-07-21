document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('.login-form');
    const feedback = document.getElementById('loginFeedback');
    const csrfToken = document.querySelector('input[name="_csrf_token"]').value;

// Log do token CSRF para depuração
    if (!form || !feedback) return;

    form.addEventListener('submit', async (e) => {
        e.preventDefault();

        // Exibe feedback de carregamento
        feedback.textContent = 'Enviando...';
        feedback.style.color = '#fff';
        feedback.style.transition = 'opacity 0.3s ease';
        feedback.style.opacity = '1';

        const formData = new FormData(form);
        formData.append('_csrf_token', csrfToken);

        try {
            const response = await fetch('/login', {
                method: 'POST',
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            });

            const result = await response.json();

            if (response.ok && result.success) {
             debugger;
                // Login bem-sucedido
                feedback.textContent = result.message || 'Login realizado com sucesso!';
                feedback.style.color = '#09c4e5';
                // Redireciona com base no campo 'redirect'
                setTimeout(() => {
                    window.location.href = result.redirect || '/sigo/dashboard';
                }, 1500); // Dá 1.5s para o usuário ver a mensagem
            } else {
                // Erro no login
                feedback.textContent = result.message || 'E-mail ou senha inválidos.';
                feedback.style.color = '#ff4d4d';
                // Redireciona para a página de login em caso de erro
                setTimeout(() => {
                    window.location.href = result.redirect || '/login';
                }, 1500);
            }
        } catch (error) {
            // Erro de conexão ou servidor
            feedback.textContent = 'Erro ao conectar. Tente novamente.';
            feedback.style.color = '#ff4d4d';
            console.error('Erro:', error);
            setTimeout(() => {
                window.location.href = '/login';
            }, 1500);
        }
    });
});