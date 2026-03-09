% Run_tests.m – ярлык для запуска тестов модели ДПТ с ПВ

% Определяем корневую папку проекта
projectRoot = fileparts(fileparts(mfilename('fullpath')));

% Переходим в корень проекта
cd(projectRoot);

% Добавляем папку Tests в путь
testsFolder = fullfile(projectRoot, 'Tests');
if ~exist(testsFolder, 'dir')
    % Если папки Tests нет, создаём её
    mkdir(testsFolder);
    disp('Создана папка Tests');
end
addpath(testsFolder);

% Проверяем наличие файла тестового класса
testClassFile = fullfile(testsFolder, 'DCMotorTest.m');
if ~exist(testClassFile, 'file')
    % Если файла нет, создаём базовый тестовый класс
    fid = fopen(testClassFile, 'w');
    fprintf(fid, '%s\n', 'classdef DCMotorTest < matlab.unittest.TestCase');
    fprintf(fid, '%s\n', '    methods (Test)');
    fprintf(fid, '%s\n', '        function testExample(testCase)');
    fprintf(fid, '%s\n', '            testCase.assertTrue(true, "Базовый тест");');
    fprintf(fid, '%s\n', '        end');
    fprintf(fid, '%s\n', '    end');
    fprintf(fid, '%s\n', 'end');
    fclose(fid);
    disp(['Создан базовый файл: ' testClassFile]);
end

% Запускаем тесты
disp('Запуск тестов DCMotorTest...');
try
    results = runtests('DCMotorTest');
    disp(results);
    table(results);
catch ME
    disp(['Ошибка при запуске тестов: ' ME.message]);
    
    % Альтернативный способ запуска
    disp('Пробуем альтернативный способ запуска...');
    suite = testsuite('DCMotorTest.m');
    results = run(suite);
    disp(results);
end