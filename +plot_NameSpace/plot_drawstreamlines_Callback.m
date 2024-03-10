function plot_drawstreamlines_Callback(~, ~, ~)
handles=gui_NameSpace.gui_gethand;
toggler=gui_NameSpace.gui_retr('toggler');
selected=2*floor(get(handles.fileselector, 'value'))-(1-toggler);
resultslist=gui_NameSpace.gui_retr('resultslist');
currentframe=floor(get(handles.fileselector, 'value'));
if size(resultslist,2)>=currentframe && numel(resultslist{1,currentframe})>0
	gui_NameSpace.gui_toolsavailable(0);
	x=resultslist{1,currentframe};
	y=resultslist{2,currentframe};
	typevector=resultslist{5,currentframe};
	if size(resultslist,1)>6 %filtered exists
		if size(resultslist,1)>10 && numel(resultslist{10,currentframe}) > 0 %smoothed exists
			u=resultslist{10,currentframe};
			v=resultslist{11,currentframe};
			typevector=resultslist{9,currentframe}; %von smoothed
		else
			u=resultslist{7,currentframe};
			if size(u,1)>1
				v=resultslist{8,currentframe};
				typevector=resultslist{9,currentframe}; %von smoothed
			else
				u=resultslist{3,currentframe};
				v=resultslist{4,currentframe};
				typevector=resultslist{5,currentframe};
			end
		end
	else
		u=resultslist{3,currentframe};
		v=resultslist{4,currentframe};
	end
	ismean=gui_NameSpace.gui_retr('ismean');
	if    numel(ismean)>0
		if ismean(currentframe)==1 %if current frame is a mean frame, typevector is stored at pos 5
			typevector=resultslist{5,currentframe};
		end
	end
	calu=gui_NameSpace.gui_retr('calu');calv=gui_NameSpace.gui_retr('calv');
	ustream=u-(gui_NameSpace.gui_retr('subtr_u')/gui_NameSpace.gui_retr('calu'));
	vstream=v-(gui_NameSpace.gui_retr('subtr_v')/gui_NameSpace.gui_retr('calv'));
	ustream(typevector==0)=nan;
	vstream(typevector==0)=nan;
	calxy=gui_NameSpace.gui_retr('calxy');
	button=1;
	streamlinesX=gui_NameSpace.gui_retr('streamlinesX');
	streamlinesY=  gui_NameSpace.gui_retr('streamlinesY');
	if get(handles.holdstream,'value')==1
		if numel(streamlinesX)>0
			i=size(streamlinesX,2)+1;
			xposition=streamlinesX;
			yposition=streamlinesY;
		else
			i=1;
		end
	else
		i=1;
		gui_NameSpace.gui_put('streamlinesX',[]);
		gui_NameSpace.gui_put('streamlinesY',[]);
		xposition=[];
		yposition=[];
		delete(findobj('tag','streamline'));
	end
	while button == 1
		[rawx,rawy,button] = ginput(1);
		if button~=1
			break
		end
		xposition(i)=rawx;
		yposition(i)=rawy;

		h=streamline(mmstream2(x,y,ustream,vstream,xposition(i),yposition(i),'on'));
		set (h,'tag','streamline');
		i=i+1;
	end
	delete(findobj('tag','streamline'));
	if exist('xposition','var')==1
		h=streamline(mmstream2(x,y,ustream,vstream,xposition,yposition,'on'));
		set (h,'tag','streamline');
		contents = get(handles.streamlcolor,'String');
		set(h,'LineWidth',get(handles.streamlwidth,'value'),'Color', contents{get(handles.streamlcolor,'Value')})
		gui_NameSpace.gui_put('streamlinesX',xposition);
		gui_NameSpace.gui_put('streamlinesY',yposition);
	end
end
gui_NameSpace.gui_toolsavailable(1);
