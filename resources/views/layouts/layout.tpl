<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Compiled and minified CSS -->
    @css(https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css)
    @css(https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.css)
    @css(https://fonts.googleapis.com/icon?family=Material+Icons)

    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
    
    {{! $styles }}
    @js(https://cdn.jsdelivr.net/npm/sweetalert2@11)
    
    <title>{{ $titulo }}</title>
</head>
<body>   
    <main>
        {{ $content }}
    </main>
    <footer>
        
    </footer>
    @js( 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js' )
    

    {{! $scripts}}
</body>
</html>