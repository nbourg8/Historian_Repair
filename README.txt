Historian Repair Tool Version 2.0.0.0
---------------------------------------------------------------------

Requirements:
	Image Versions 2.x.x.x or above
	Run with Administrative credentials - e.g. CanrigAdmin
---------------------------------------------------------------------
Purpose:
	This tool is used to quickly perform a 'historian repair'.

	This tool does the following in order:
	
	Create log.txt in same folder as main.bat to keep record of files modified/moved/deleted
	Stop FTLD and PIBUFSS services on PRIM HMI Server and delete appropriate ftld* files and move pibufq_ files of date < user specified days to folder ..\pibufq_Backup
	Stop FTLD and PIBUFSS services on SEC HMI Server and delete appropriate ftld* files and move pibufq_ files of date < user specified days to folder ..\pibufq_Backup
	Stop PIARCHSS and PISNAPSS Services on Historian, delete pimq* files older than user specified days and move the rest to folder ..\evq
	Start PISNAPSS and PIARCHSS Services on Historian
	Start FTLD on both PRIM and SEC HMI Servers
	
---------------------------------------------------------------------
Revision History
2.0.0.0 - Initial Release	