@echo off
REM Verification script to check if everything is set up correctly

echo ============================================
echo Project Structure Verification
echo ============================================
echo.

set ERROR_COUNT=0

REM Check dbapp files
echo [1/15] Checking dbapp/app.py...
if exist "dbapp\app.py" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [2/15] Checking dbapp/Dockerfile...
if exist "dbapp\Dockerfile" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [3/15] Checking dbapp/.dockerignore...
if exist "dbapp\.dockerignore" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [4/15] Checking dbapp/requirements.txt...
if exist "dbapp\requirements.txt" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

REM Check webapp files
echo [5/15] Checking webapp/app.py...
if exist "webapp\app.py" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [6/15] Checking webapp/Dockerfile...
if exist "webapp\Dockerfile" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [7/15] Checking webapp/.dockerignore...
if exist "webapp\.dockerignore" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [8/15] Checking webapp/requirements.txt...
if exist "webapp\requirements.txt" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [9/15] Checking webapp/model.pkl...
if exist "webapp\model.pkl" (
    echo   ✓ Found
) else (
    echo   ⚠ Not found - Run: cd webapp ^&^& python train_model.py
    set /a ERROR_COUNT+=1
)

echo [10/15] Checking webapp/templates/index.html...
if exist "webapp\templates\index.html" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [11/15] Checking webapp/templates/display_records.html...
if exist "webapp\templates\display_records.html" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

REM Check root files
echo [12/15] Checking test_sample.py...
if exist "test_sample.py" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [13/15] Checking docker-compose.yml...
if exist "docker-compose.yml" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [14/15] Checking Jenkinsfile...
if exist "Jenkinsfile" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo [15/15] Checking README.md...
if exist "README.md" (
    echo   ✓ Found
) else (
    echo   ✗ Missing
    set /a ERROR_COUNT+=1
)

echo.
echo ============================================

if %ERROR_COUNT% EQU 0 (
    echo ✓ All files present! Structure is correct.
    echo.
    echo Next Steps:
    echo   1. Train model: cd webapp ^&^& python train_model.py
    echo   2. Run setup: setup.bat
    echo   3. Or manually: docker-compose up --build
    echo.
) else (
    echo ✗ Found %ERROR_COUNT% missing file(s)
    echo Please ensure all files are created properly.
    echo.
)

echo File Structure Should Be:
echo demo_project/
echo  ├── dbapp/
echo  │   ├── app.py
echo  │   ├── Dockerfile
echo  │   ├── .dockerignore
echo  │   └── requirements.txt
echo  ├── webapp/
echo  │   ├── app.py
echo  │   ├── train_model.py
echo  │   ├── model.pkl
echo  │   ├── Dockerfile
echo  │   ├── .dockerignore
echo  │   ├── requirements.txt
echo  │   └── templates/
echo  │       ├── index.html
echo  │       └── display_records.html
echo  ├── test_sample.py
echo  ├── docker-compose.yml
echo  └── Jenkinsfile
echo.
pause
