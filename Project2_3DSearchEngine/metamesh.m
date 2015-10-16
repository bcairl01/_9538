% Mesh with extended information
% *** NON-GENERIC
classdef metamesh
    
    properties
        M           = [];   % source mesh
        ED          = [];   % ED-descriptor
        GD          = [];   % GD-descriptor
        CD          = [];   % CD-descriptor (custom)
        name        = '';   % exact name
        class       = '';   % class name
        path        = '';   % source path
    end
    
    methods
        
        
        function mmesh = metamesh(varargin)
            if nargin>0
                
                % Get the source mesh
                if      strcmpi(varargin{1},'LOAD')
                    load(varargin{2});
                    return;
                elseif  strcmpi(varargin{1},'FILE')
                    mmesh.path  = varargin{2};
                    mmesh.name  = path2meshname(mmesh.path);
                    mmesh.class = path2classname(mmesh.path);
                    mmesh.M     = meshread(varargin{2});
                elseif  strcmpi(varargin{1},'MESH')
                    mmesh.M     = varargin{2};
                else
                    error(['Unrecognized option : ',varargin{1}]);
                end
                varargin(1:2) = [];
                
                % Generate ED descriptor
                mmesh.ED = create_EDdescriptor(mmesh.M,varargin{:});
                
                % Generate GD descriptor
                mmesh.GD = create_GDdescriptor(mmesh.M,varargin{:});
                
                % Generate CD descriptor
                mmesh.CD = create_CDdescriptor(mmesh.M,varargin{:});
            end
        end
        
        
        
        function show(mmesh,varargin)
            if numel(varargin)
               if strcmpi(varargin{1},'HANDLE')
                   axes(varargin{2})
                   varargin(1:2) = [];
               end
            end
            meshview(mmesh.M,varargin{:});
        end
        
        
        function d = dist(mmesh,other)
            d       = zeros(3,1);
            d(1)    = norm(mmesh.ED - other.ED);
            d(2)    = norm(mmesh.GD - other.GD);
            d(3)    = norm(mmesh.CD - other.CD);
        end
        
        
        
        function plot(mmesh,varargin)
            subplot(3,1,1); plot(mmesh.ED,varargin{:})
            subplot(3,1,2); plot(mmesh.GD,varargin{:})
            subplot(3,1,3); plot(mmesh.CD,varargin{:})
        end
 
        
        function cplot(mmesh,other)
            N = transpose(1:numel(mmesh.ED));
            subplot(3,1,1); plot(N,mmesh.ED,'b',N,other.ED,'g')
            N = transpose(1:numel(mmesh.GD));
            subplot(3,1,2); plot(N,mmesh.GD,'b',N,other.GD,'g')
            N = transpose(1:numel(mmesh.CD));
            subplot(3,1,3); plot(N,mmesh.CD,'b',N,other.CD,'g')
        end
    end
    
end