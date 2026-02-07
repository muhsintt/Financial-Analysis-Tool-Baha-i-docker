@echo off
REM Generate self-signed SSL certificates for development/testing
REM For production, use Let's Encrypt or a trusted CA

setlocal

set SCRIPT_DIR=%~dp0
set SSL_DIR=%SCRIPT_DIR%nginx\ssl

REM Create SSL directory
if not exist "%SSL_DIR%" mkdir "%SSL_DIR%"

REM Check if OpenSSL is available
where openssl >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo ERROR: OpenSSL is not installed or not in PATH.
    echo.
    echo Install OpenSSL for Windows:
    echo   1. Download from: https://slproweb.com/products/Win32OpenSSL.html
    echo   2. Or use: winget install ShiningLight.OpenSSL
    echo   3. Or use Git Bash which includes OpenSSL
    echo.
    exit /b 1
)

REM Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 ^
    -keyout "%SSL_DIR%\key.pem" ^
    -out "%SSL_DIR%\cert.pem" ^
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"

echo.
echo SSL certificates generated successfully!
echo    Certificate: %SSL_DIR%\cert.pem
echo    Private Key: %SSL_DIR%\key.pem
echo.
echo WARNING: These are self-signed certificates for development only.
echo          For production, use Let's Encrypt or a trusted Certificate Authority.
echo.
echo To start the app with HTTPS:
echo    docker compose up -d
echo.
echo Access the app at: https://localhost

endlocal
