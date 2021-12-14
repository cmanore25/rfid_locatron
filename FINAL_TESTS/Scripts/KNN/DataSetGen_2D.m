
%% Initial Setup
XMax = 3;
YMax = 3;
GridResolution = 0.1;

x = 0:GridResolution : XMax;
y = 0:GridResolution : YMax;

%X= Index (1) of grid Y= Index(2) of grid
[X,Y] = meshgrid(x,y);
AntennaPosIndex = [X(1), Y(1); 
                                    X(1),Y(end); 
                                    X(end), Y(end);
                                    X(end), Y(1)]; % [m]   
%% Attaching distance Dataset to simulation

model = 'KNN_DataGen';
open(model)
  % ====Simulation Params Setup===== %
            FreqCarrier = 9.15e+08;
            Gr = 6; 
            Gt = 1.56; 
            Zin_r = 50; 
            Zin_t = 7.056465388996018e-01 + 2.916241413655430e+02i;
            lambdaCarrier = physconst('LightSpeed')/FreqCarrier;
            
            %Preset Distances for corroboration %
            R1 = 2.828;
            R2 = 2.236;
            R3 = 1.414;
            R4 = 2.236;
            Rtest = 1;

            set_param('KNN_DataGen/Antenna_TX','Gr',num2str(Gt))
            set_param('KNN_DataGen/Antenna_TX','Zin',num2str(Zin_t))
            set_param('KNN_DataGen/Antenna_TX','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_DataGen/PA','Zin',num2str(Zin_r))      
            set_param('KNN_DataGen/Inport','CarrierFreq',num2str(FreqCarrier))
            
            set_param('KNN_DataGen/Antenna_RX','Gr',num2str(Gr))
            set_param('KNN_DataGen/Antenna_RX1','Gr',num2str(Gr))
            set_param('KNN_DataGen/Antenna_RX2','Gr',num2str(Gr))
            set_param('KNN_DataGen/Antenna_RX3','Gr',num2str(Gr))
            set_param('KNN_DataGen/Antenna_RX4','Gr',num2str(Gr))
            set_param('KNN_DataGen/Antenna_RX','Zin',num2str(Zin_r))
            set_param('KNN_DataGen/Antenna_RX1','Zin',num2str(Zin_r))
            set_param('KNN_DataGen/Antenna_RX2','Zin',num2str(Zin_r))
            set_param('KNN_DataGen/Antenna_RX3','Zin',num2str(Zin_r))
            set_param('KNN_DataGen/Antenna_RX4','Zin',num2str(Zin_r))
            set_param('KNN_DataGen/Antenna_RX','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_DataGen/Antenna_RX1','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_DataGen/Antenna_RX2','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_DataGen/Antenna_RX3','CarrierFreqRad',num2str(FreqCarrier))
            set_param('KNN_DataGen/Antenna_RX4','CarrierFreqRad',num2str(FreqCarrier))
             
             
            set_param('KNN_DataGen/FS_PathLoss1','Gain',num2str(lambdaCarrier/(4*pi*R1)))
            set_param('KNN_DataGen/FS_PathLoss2','Gain',num2str(lambdaCarrier/(4*pi*R2)))
            set_param('KNN_DataGen/FS_PathLoss3','Gain',num2str(lambdaCarrier/(4*pi*R3)))
            set_param('KNN_DataGen/FS_PathLoss4','Gain',num2str(lambdaCarrier/(4*pi*R4)))
            set_param('KNN_DataGen/FS_PathLossTest','Gain',num2str(lambdaCarrier/(4*pi*Rtest)))
              
            set_param('KNN_DataGen/LNA','Zin',num2str(Zin_r'))
            set_param('KNN_DataGen/LNA1','Zin',num2str(Zin_r'))
            set_param('KNN_DataGen/LNA2','Zin',num2str(Zin_r'))
            set_param('KNN_DataGen/LNA3','Zin',num2str(Zin_r'))
            set_param('KNN_DataGen/LNA4','Zin',num2str(Zin_r'))
             
     
           set_param('KNN_DataGen/RA1','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_DataGen/RA2','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_DataGen/RA3','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_DataGen/RA4','CarrierFreq',num2str(FreqCarrier))
           set_param('KNN_DataGen/RA5','CarrierFreq',num2str(FreqCarrier))

            
%% Coordinate System on Matrices
%      (0,0)     0     0     0     0     0     0     0     0     0     0    (0,3)  
%           0     0     0     0     0     0     0     0     0     0     0     0   
%           0     0     0     0     0     0     0     0     0     0     0     0     
%           0     0     0     0     0     0     0     0     0     0     0     0   
%           0     0     0     0     0     0     0     0     0     0     0     0    
%      (3,0)    0     0     0     0     0     0     0     0     0     0     (3,3)     
%% Coordinate System on images
%      (0,3)     0     0     0     0     0     0     0     0     0     0    (3,3)  
%           0     0     0     0     0     0     0     0     0     0     0     0   
%           0     0     0     0     0     0     0     0     0     0     0     0     
%           0     0     0     0     0     0     0     0     0     0     0     0   
%           0     0     0     0     0     0     0     0     0     0     0     0    
%      (0,0)    0     0     0     0     0     0     0     0     0     0     (3,0)     
% Triangulation function might need changing
%% 
% DistMatrix  = zeros(length(AntennaPosIndex), XMax / GridResolution, YMax / GridResolution);
%  for AntennaPosCounter = 2:size(AntennaPosIndex,1)
%     for x_index = 1 : (XMax) / GridResolution +1
%         for y_index =1 : (YMax) / GridResolution +1
%             Tag_pos = [(x_index-1)*GridResolution, (y_index-1)*GridResolution];   
%              DistMatrix(AntennaPosCounter, x_index,y_index) =  distanceCalc(AntennaPosIndex(AntennaPosCounter,:), Tag_pos);
%         end
%     end
%  end

Data.Antenna1.AntennaPos = AntennaPosIndex(1,:);  
Data.Antenna2.AntennaPos = AntennaPosIndex(2,:);  
Data.Antenna3.AntennaPos = AntennaPosIndex(3,:);  
Data.Antenna4.AntennaPos =AntennaPosIndex(4,:);  

Data.Antenna1.DistMat = zeros( XMax / GridResolution, YMax / GridResolution);
Data.Antenna2.DistMat = zeros( XMax / GridResolution, YMax / GridResolution);
Data.Antenna3.DistMat = zeros( XMax / GridResolution, YMax / GridResolution);
Data.Antenna4.DistMat = zeros( XMax / GridResolution, YMax / GridResolution);

Data.Antenna1.RSSI = zeros( XMax / GridResolution, YMax / GridResolution);
Data.Antenna2.RSSI = zeros( XMax / GridResolution, YMax / GridResolution);
Data.Antenna3.RSSI = zeros( XMax / GridResolution, YMax / GridResolution);
Data.Antenna4.RSSI = zeros( XMax / GridResolution, YMax / GridResolution);

 for AntennaPosCounter = 1:size(AntennaPosIndex,1)
    for x_index = 1 : (XMax) / GridResolution +1
        for y_index =1 : (YMax) / GridResolution +1

            Tag_pos = [(x_index-1)*GridResolution, (y_index-1)*GridResolution];   
            Data.Antenna1.DistMat( x_index,y_index)=  distanceCalc(Data.Antenna1.AntennaPos, Tag_pos);
            Data.Antenna2.DistMat( x_index,y_index)=  distanceCalc(Data.Antenna2.AntennaPos, Tag_pos);
            Data.Antenna3.DistMat( x_index,y_index)=  distanceCalc(Data.Antenna3.AntennaPos, Tag_pos);
            Data.Antenna4.DistMat( x_index,y_index)=  distanceCalc(Data.Antenna4.AntennaPos, Tag_pos);
            if((x_index == 1 && y_index ==1) || ...
                    (x_index == 1 && y_index ==(YMax) / GridResolution +1) ||...
                    (x_index == (XMax) / GridResolution +1 && y_index == 1) || ...
                    (x_index == (XMax) / GridResolution +1 && y_index == (YMax) / GridResolution +1))
                         Data.Antenna1.RSSI( x_index,y_index)  = inf;
                        Data.Antenna2.RSSI( x_index,y_index) = inf;
                        Data.Antenna3.RSSI( x_index,y_index) = inf;
                        Data.Antenna4.RSSI( x_index,y_index) = inf;
            else
                     %============SIMULATION CALL==================%
                set_param('KNN_DataGen/FS_PathLoss1','Gain',num2str(lambdaCarrier/(4*pi*  Data.Antenna1.DistMat( x_index,y_index))))
                set_param('KNN_DataGen/FS_PathLoss2','Gain',num2str(lambdaCarrier/(4*pi* Data.Antenna2.DistMat( x_index,y_index))))
                set_param('KNN_DataGen/FS_PathLoss3','Gain',num2str(lambdaCarrier/(4*pi*Data.Antenna3.DistMat( x_index,y_index))))
                set_param('KNN_DataGen/FS_PathLoss4','Gain',num2str(lambdaCarrier/(4*pi*Data.Antenna4.DistMat( x_index,y_index))))
    
                SimOutput = sim(model, 'FastRestart', 'on');
                %Obtained Signal Strengths
                Data.Antenna1.RSSI( x_index,y_index) = mean(SimOutput.RSSI1(1));
                Data.Antenna2.RSSI( x_index,y_index) = mean(SimOutput.RSSI2(1));
                Data.Antenna3.RSSI( x_index,y_index) = mean(SimOutput.RSSI3(1));
                Data.Antenna4.RSSI( x_index,y_index) = mean(SimOutput.RSSI4(1));
            end
                %=============================================%
        end
    end
 end
 
 clearvars -except Data DistMatrix GridResolution XMax YMax



function [dist2d] = distanceCalc(AntennaPos, TagPos)
    dist2d = norm(TagPos-AntennaPos);
end




