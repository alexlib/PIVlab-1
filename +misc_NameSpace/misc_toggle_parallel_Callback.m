function misc_toggle_parallel_Callback(~, ~, ~)
hgui=getappdata(0,'hgui');
handles=gui_NameSpace.gui_gethand;
load icons.mat
try
	parallel=gui_NameSpace.gui_retr('parallel');
	if parallel==0
		gui_NameSpace.gui_put ('parallel',1);
		gui_NameSpace.gui_toolsavailable(0,'Please wait, opening parallel pool...')
		pause(0.1)
		desired_num_cores=feature('numCores');
		pivparpool('close')
		pivparpool('open',desired_num_cores)
		set(handles.toggle_parallel, 'cdata',parallel_on,'TooltipString','Parallel processing on. Click to turn off.');
	else
		gui_NameSpace.gui_put ('parallel',0);
		gui_NameSpace.gui_toolsavailable(0,'Please wait, closing parallel pool...')
		pivparpool('close')
		set(handles.toggle_parallel, 'cdata',parallel_off,'TooltipString','Parallel processing off. Click to turn on.');
	end
	gui_NameSpace.gui_toolsavailable(1);
catch ME
	gui_NameSpace.gui_put ('parallel',0);
	set(handles.toggle_parallel, 'cdata',parallel_off,'enable','off', 'TooltipString','Parallel processing not avilable.');
	gui_NameSpace.gui_toolsavailable(1);
	disp (ME.message)
end
