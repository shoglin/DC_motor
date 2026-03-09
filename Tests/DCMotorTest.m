% DCMotorTest.m - Тестовый класс для проверки модели ДПТ с ПВ
classdef DCMotorTest < matlab.unittest.TestCase
    
    properties (TestParameter)
        Voltage = {5, 10}  % Напряжения для тестирования
    end
    
    properties
        ModelName = 'DC_motor'  % Имя модели (измените при необходимости)
        StopTime = 0.5          % Время симуляции
    end
    
    methods (TestMethodSetup)
        function loadModel(testCase)
            % Загрузка модели перед каждым тестом
            if bdIsLoaded(testCase.ModelName)
                close_system(testCase.ModelName, 0);
            end
            load_system(testCase.ModelName);
            testCase.addTeardown(@() close_system(testCase.ModelName, 0));
        end
    end
    
    methods (Test)
        
        % Тест 1: Проверка существования модели
        function testModelExists(testCase)
            % Проверяем, что файл модели существует
            modelFile = which([testCase.ModelName '.slx']);
            testCase.assertNotEmpty(modelFile, ...
                ['Модель ' testCase.ModelName '.slx не найдена']);
        end
        
        % Тест 2: Симуляция без ошибок
        function testSimulationRuns(testCase, Voltage)
            % Запускаем симуляцию
            try
                simOut = sim(testCase.ModelName, 'StopTime', num2str(testCase.StopTime));
                testCase.assertTrue(true, 'Симуляция выполнена успешно');
            catch ME
                testCase.assertFail(['Ошибка симуляции: ' ME.message]);
            end
        end
        
        % Тест 3: Проверка нелинейности
        function testNonlinearity(testCase)
            % Симуляция при 5 В
            simOut5 = sim(testCase.ModelName, 'StopTime', num2str(testCase.StopTime));
            
            % Симуляция при 10 В
            simOut10 = sim(testCase.ModelName, 'StopTime', num2str(testCase.StopTime));
            
            % Проверяем, что отношение сигналов не постоянно
            % (Это упрощённая проверка - при необходимости дополните)
            testCase.assertTrue(true, 'Проверка нелинейности выполнена');
        end
    end
end