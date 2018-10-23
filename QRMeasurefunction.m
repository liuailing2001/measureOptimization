function [PhiQR]= QRMeasurefunction(Phi)
          [Q,R]=qr(Phi');
            [a,b]=size(R);
            for i=1:a
                for j=i:b
                    if i~=j
                        R(i,j)=0;
                    end
                end
            end
%             ymax=max(max(R));
%              for i=1:a
%                 for j=i:b
%                     if i==j
%                         R(i,j)=ymax;
%                     end
%                 end
%             end
            PhiQR=R'*Q';