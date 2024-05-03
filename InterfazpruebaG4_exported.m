classdef InterfazpruebaG4_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        prue2                          matlab.ui.control.Label
        prue                           matlab.ui.control.Label
        AlcoholLabel                   matlab.ui.control.Label
        GeneroLabel                    matlab.ui.control.Label
        ECVLabel                       matlab.ui.control.Label
        ActividadFisicaLabel           matlab.ui.control.Label
        Label_9                        matlab.ui.control.Label
        FumaLabel                      matlab.ui.control.Label
        Label_6                        matlab.ui.control.Label
        Label_5                        matlab.ui.control.Label
        Label_4                        matlab.ui.control.Label
        Label_3                        matlab.ui.control.Label
        Label_2                        matlab.ui.control.Label
        puntos56                       matlab.ui.control.ListBox
        QuedeseagraficarListBoxLabel   matlab.ui.control.Label
        icmestatico                    matlab.ui.control.Label
        icmdinamico                    matlab.ui.control.Label
        calcularicm                    matlab.ui.control.Button
        TabGroup                       matlab.ui.container.TabGroup
        PacientesconECVTab             matlab.ui.container.Tab
        ColesterolButton               matlab.ui.control.Button
        CalcularPresionArterialButton  matlab.ui.control.Button
        DequevariabledeseaconocerlamediayladesviacionestandarLabel  matlab.ui.control.Label
        calICMcon                      matlab.ui.control.Button
        Label_8                        matlab.ui.control.Label
        Label_7                        matlab.ui.control.Label
        DesviacionestandarLabel_2      matlab.ui.control.Label
        MediaLabel_2                   matlab.ui.control.Label
        PacientessinECVTab             matlab.ui.container.Tab
        CalcularButton                 matlab.ui.control.Button
        Label2                         matlab.ui.control.Label
        Label                          matlab.ui.control.Label
        DesviacionestandarLabel        matlab.ui.control.Label
        MediaLabel                     matlab.ui.control.Label
        DequevariabledeseaconocerlamediayladesviacionestandarListBox  matlab.ui.control.ListBox
        ListBoxLabel                   matlab.ui.control.Label
        IDparticipante                 matlab.ui.control.NumericEditField
        IDpersonaEditFieldLabel        matlab.ui.control.Label
        Graficarboton                  matlab.ui.control.Button
        grafica1                       matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        HeartData %tabla con datos de enfermedades cardiacas
        
    end
    
    methods (Access = private)
        
        function  preprocesamiento(app)
            app.HeartData.height = app.HeartData.height / 100;
            app.HeartData.age = app.HeartData.age /365;



fuma =   app.HeartData.smoke; %%parte para covertir 1,0 en "fumador"
texfum = ["No fuma"; "Fuma"];
reemplazofum = texfum (fuma + 1); 
app.HeartData.smoke = reemplazofum;


alcohol= app.HeartData.alco; %%parte para covertir 1,0 en "alcohol"
texalcohol = ["No consume alcohol"; "Consume alcohol"];
reemplazoalcohol = texalcohol (alcohol + 1);
app.HeartData.alco = reemplazoalcohol;


actividad = app.HeartData.active;  %%parte para covertir 1,0 en "actividad"
texactividad = ["No hace actividad fisica"; "Hace actividad fisica"];
reemplazoactividad = texactividad (actividad + 1);
app.HeartData.active = reemplazoactividad;






        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
load("workspacesg4.mat","TablaConTodosLosDatos");
app.HeartData = TablaConTodosLosDatos;
preprocesamiento(app);
        end

        % Button pushed function: Graficarboton
        function GraficarbotonButtonPushed(app, event)


        end

        % Button pushed function: calcularicm
        function calcularicmButtonPushed(app, event)
            ID = app.IDparticipante.Value;
peso = app.HeartData.weight(ID);
altura = app.HeartData.height(ID);
imc = peso/altura^2;
app.icmdinamico.Text= num2str(imc, "%.2f");

fuma = app.HeartData.smoke(ID); %%prueba fumador
app.Label_2.Text = num2str(fuma);

alcohol = app.HeartData.alco(ID); %%prueba alcohol
app.Label_3.Text = num2str(alcohol); 

actividad = app.HeartData.active (ID); %%prueba actividad fisica
app.Label_4.Text = num2str(actividad);

cardio = app.HeartData.cardio (ID);
app.Label_5.Text = num2str(cardio);

genero = app.HeartData.gender (ID);
app.Label_6.Text = num2str(genero);



        


        end

        % Value changed function: puntos56
        function puntos56ValueChanged(app, event)
            
        end

        % Button pushed function: calICMcon
        function calICMconPushed(app, event)
   

            
            
              
conECV = [];
sinECV = [];

for i = 1:size(app.HeartData.cardio, 1)    

    
    if app.HeartData.cardio(i) == 1
        conECV = [conECV; app.HeartData.cardio(i, :)]; 

        num_con = size(conECV, 1);

peso = app.HeartData.weight;
altura = app.HeartData.height;
imc = peso/altura^2;

        


    elseif app.HeartData.cardio(i) == 0
        sinECV = [sinECV; app.HeartData.cardio(i, :)]; 
    end

end
num_con = size(conECV, 1);



media = mean(num_con);

app.Label_7.Text= num2str(media);


num_sin = size(sinECV, 1);
app.prue2.Text= num2str(num_sin);

            
                    
            

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create grafica1
            app.grafica1 = uiaxes(app.UIFigure);
            title(app.grafica1, 'Peso vs Altura')
            xlabel(app.grafica1, 'Peso')
            ylabel(app.grafica1, 'Altura')
            zlabel(app.grafica1, 'Z')
            app.grafica1.Position = [343 284 282 186];

            % Create Graficarboton
            app.Graficarboton = uibutton(app.UIFigure, 'push');
            app.Graficarboton.ButtonPushedFcn = createCallbackFcn(app, @GraficarbotonButtonPushed, true);
            app.Graficarboton.Position = [446 250 100 23];
            app.Graficarboton.Text = 'Graficar';

            % Create IDpersonaEditFieldLabel
            app.IDpersonaEditFieldLabel = uilabel(app.UIFigure);
            app.IDpersonaEditFieldLabel.Position = [32 194 64 22];
            app.IDpersonaEditFieldLabel.Text = 'ID persona';

            % Create IDparticipante
            app.IDparticipante = uieditfield(app.UIFigure, 'numeric');
            app.IDparticipante.Limits = [1 70000];
            app.IDparticipante.ValueDisplayFormat = '%.0f';
            app.IDparticipante.Placeholder = '1';
            app.IDparticipante.Position = [111 194 100 22];
            app.IDparticipante.Value = 1;

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [11 249 301 221];

            % Create PacientesconECVTab
            app.PacientesconECVTab = uitab(app.TabGroup);
            app.PacientesconECVTab.Title = 'Pacientes con ECV';

            % Create MediaLabel_2
            app.MediaLabel_2 = uilabel(app.PacientesconECVTab);
            app.MediaLabel_2.Position = [34 94 41 22];
            app.MediaLabel_2.Text = 'Media:';

            % Create DesviacionestandarLabel_2
            app.DesviacionestandarLabel_2 = uilabel(app.PacientesconECVTab);
            app.DesviacionestandarLabel_2.Position = [33 52 117 22];
            app.DesviacionestandarLabel_2.Text = 'Desviacion estandar:';

            % Create Label_7
            app.Label_7 = uilabel(app.PacientesconECVTab);
            app.Label_7.Position = [84 94 66 22];
            app.Label_7.Text = '';

            % Create Label_8
            app.Label_8 = uilabel(app.PacientesconECVTab);
            app.Label_8.Position = [157 52 55 22];
            app.Label_8.Text = '';

            % Create calICMcon
            app.calICMcon = uibutton(app.PacientesconECVTab, 'push');
            app.calICMcon.ButtonPushedFcn = createCallbackFcn(app, @calICMconPushed, true);
            app.calICMcon.Position = [191 158 100 23];
            app.calICMcon.Text = 'Calcular ICM';

            % Create DequevariabledeseaconocerlamediayladesviacionestandarLabel
            app.DequevariabledeseaconocerlamediayladesviacionestandarLabel = uilabel(app.PacientesconECVTab);
            app.DequevariabledeseaconocerlamediayladesviacionestandarLabel.Position = [26 137 132 44];
            app.DequevariabledeseaconocerlamediayladesviacionestandarLabel.Text = {'¿De que variable desea'; 'conocer la media y la'; 'desviacion estandar?'};

            % Create CalcularPresionArterialButton
            app.CalcularPresionArterialButton = uibutton(app.PacientesconECVTab, 'push');
            app.CalcularPresionArterialButton.Position = [156 135 144 23];
            app.CalcularPresionArterialButton.Text = 'Calcular Presion Arterial';

            % Create ColesterolButton
            app.ColesterolButton = uibutton(app.PacientesconECVTab, 'push');
            app.ColesterolButton.Position = [191 109 100 23];
            app.ColesterolButton.Text = 'Colesterol';

            % Create PacientessinECVTab
            app.PacientessinECVTab = uitab(app.TabGroup);
            app.PacientessinECVTab.Title = 'Pacientes sin ECV';

            % Create ListBoxLabel
            app.ListBoxLabel = uilabel(app.PacientessinECVTab);
            app.ListBoxLabel.HorizontalAlignment = 'right';
            app.ListBoxLabel.Position = [1 137 132 44];
            app.ListBoxLabel.Text = {'¿De que variable desea'; 'conocer la media y la'; 'desviacion estandar?'};

            % Create DequevariabledeseaconocerlamediayladesviacionestandarListBox
            app.DequevariabledeseaconocerlamediayladesviacionestandarListBox = uilistbox(app.PacientessinECVTab);
            app.DequevariabledeseaconocerlamediayladesviacionestandarListBox.Items = {'Índice de masa corporal', 'Presión arterial media', 'Colesterol'};
            app.DequevariabledeseaconocerlamediayladesviacionestandarListBox.Position = [148 109 143 74];
            app.DequevariabledeseaconocerlamediayladesviacionestandarListBox.Value = 'Índice de masa corporal';

            % Create MediaLabel
            app.MediaLabel = uilabel(app.PacientessinECVTab);
            app.MediaLabel.Position = [33 74 41 22];
            app.MediaLabel.Text = 'Media:';

            % Create DesviacionestandarLabel
            app.DesviacionestandarLabel = uilabel(app.PacientessinECVTab);
            app.DesviacionestandarLabel.Position = [33 35 117 22];
            app.DesviacionestandarLabel.Text = 'Desviacion estandar:';

            % Create Label
            app.Label = uilabel(app.PacientessinECVTab);
            app.Label.Position = [100 74 34 22];

            % Create Label2
            app.Label2 = uilabel(app.PacientessinECVTab);
            app.Label2.Position = [159 35 41 22];
            app.Label2.Text = 'Label2';

            % Create CalcularButton
            app.CalcularButton = uibutton(app.PacientessinECVTab, 'push');
            app.CalcularButton.Position = [191 73 100 23];
            app.CalcularButton.Text = 'Calcular';

            % Create calcularicm
            app.calcularicm = uibutton(app.UIFigure, 'push');
            app.calcularicm.ButtonPushedFcn = createCallbackFcn(app, @calcularicmButtonPushed, true);
            app.calcularicm.Position = [244 194 100 23];
            app.calcularicm.Text = 'Informacion';

            % Create icmdinamico
            app.icmdinamico = uilabel(app.UIFigure);
            app.icmdinamico.Position = [105 147 60 22];
            app.icmdinamico.Text = '';

            % Create icmestatico
            app.icmestatico = uilabel(app.UIFigure);
            app.icmestatico.Position = [36 147 60 22];
            app.icmestatico.Text = 'El ICM es:';

            % Create QuedeseagraficarListBoxLabel
            app.QuedeseagraficarListBoxLabel = uilabel(app.UIFigure);
            app.QuedeseagraficarListBoxLabel.HorizontalAlignment = 'right';
            app.QuedeseagraficarListBoxLabel.Position = [378 204 121 22];
            app.QuedeseagraficarListBoxLabel.Text = '¿Que desea graficar?';

            % Create puntos56
            app.puntos56 = uilistbox(app.UIFigure);
            app.puntos56.Items = {'Punto 5', 'Punto 6'};
            app.puntos56.ValueChangedFcn = createCallbackFcn(app, @puntos56ValueChanged, true);
            app.puntos56.Position = [514 182 100 46];
            app.puntos56.Value = 'Punto 5';

            % Create Label_2
            app.Label_2 = uilabel(app.UIFigure);
            app.Label_2.Position = [79 117 156 22];
            app.Label_2.Text = '';

            % Create Label_3
            app.Label_3 = uilabel(app.UIFigure);
            app.Label_3.Position = [278 117 181 22];
            app.Label_3.Text = '';

            % Create Label_4
            app.Label_4 = uilabel(app.UIFigure);
            app.Label_4.Position = [127 83 121 22];
            app.Label_4.Text = '';

            % Create Label_5
            app.Label_5 = uilabel(app.UIFigure);
            app.Label_5.Position = [74 43 148 22];
            app.Label_5.Text = '';

            % Create Label_6
            app.Label_6 = uilabel(app.UIFigure);
            app.Label_6.Position = [278 147 106 22];
            app.Label_6.Text = '';

            % Create FumaLabel
            app.FumaLabel = uilabel(app.UIFigure);
            app.FumaLabel.Position = [36 117 39 22];
            app.FumaLabel.Text = 'Fuma:';

            % Create Label_9
            app.Label_9 = uilabel(app.UIFigure);
            app.Label_9.Position = [278 53 156 22];
            app.Label_9.Text = '';

            % Create ActividadFisicaLabel
            app.ActividadFisicaLabel = uilabel(app.UIFigure);
            app.ActividadFisicaLabel.Position = [36 83 92 22];
            app.ActividadFisicaLabel.Text = 'Actividad Fisica:';

            % Create ECVLabel
            app.ECVLabel = uilabel(app.UIFigure);
            app.ECVLabel.Position = [36 43 33 22];
            app.ECVLabel.Text = 'ECV:';

            % Create GeneroLabel
            app.GeneroLabel = uilabel(app.UIFigure);
            app.GeneroLabel.Position = [231 147 48 22];
            app.GeneroLabel.Text = 'Genero:';

            % Create AlcoholLabel
            app.AlcoholLabel = uilabel(app.UIFigure);
            app.AlcoholLabel.Position = [231 117 48 22];
            app.AlcoholLabel.Text = 'Alcohol:';

            % Create prue
            app.prue = uilabel(app.UIFigure);
            app.prue.Position = [474 104 113 22];
            app.prue.Text = '';

            % Create prue2
            app.prue2 = uilabel(app.UIFigure);
            app.prue2.Position = [486 64 101 22];
            app.prue2.Text = '';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = InterfazpruebaG4_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end