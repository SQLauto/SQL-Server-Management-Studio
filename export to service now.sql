--		;WITH		ClusterNodeA
--				AS
--				(
--				SELECT		ClusterName
--						,ResourceName
--						,State
--				FROM		[dbacentral].[dbo].[DBA_ClusterInfo]
--				WHERE		[ResourceType] = 'Node'
--					AND	ResourceName NOT IN (SELECT ServerName FROM [dbacentral].[dbo].[DBA_ServerInfo])
--				)
--SELECT		*
--FROM		(

--		SELECT		DISTINCT
--				UPPER(T1.ClusterName) [ClusterName]
--				,UPPER(T1.[ResourceName]) [ServerName]
--				,UPPER(DomainName) [DomainName]	
--				,UPPER(T1.[ResourceName]+ CASE	WHEN DomainName = 'amer'	THEN '.amer.gettywan.com'
--								WHEN DomainName = 'production'	THEN '.production.local'
--								WHEN DomainName = 'stage'	THEN '.stage.local'
--								END) [FQDN]	
--				,'Cluster Node' [ServerType]	
--				,(SELECT ResourceDetail FROM [dbacentral].[dbo].[DBA_ClusterInfo] WHERE ResourceType = 'Network Interface' AND ResourceName Like '%'+T1.ResourceName+'%' AND ResourceName Like '%Public%') [NodePublicIP]
--				,(SELECT ResourceDetail FROM [dbacentral].[dbo].[DBA_ClusterInfo] WHERE ResourceType = 'Network Interface' AND ResourceName Like '%'+T1.ResourceName+'%' AND ResourceName Like '%Private%') [NodePrivateIP]
--		FROM		ClusterNodeA T1
--		JOIN		[dbacentral].[dbo].[DBA_ServerInfo] T2
--			ON	T2.[Cluster] = T1.ClusterName
--		WHERE		T2.[SQLEnv] = 'Production'
--			AND	T2.[Active] != 'N'
--			AND	NULLIF(T2.[Cluster],'') Is Not Null
--		) Data


SELECT		*
FROM		(
		SELECT		DISTINCT
				UPPER([ServerName]) [ServerName]
				,UPPER(SQLName) [SQLName]
				,UPPER(DomainName) [DomainName]
				,UPPER(COALESCE(FQDN,[ServerName]+ CASE	WHEN DomainName = 'amer'	THEN '.amer.gettywan.com'
									WHEN DomainName = 'production'	THEN '.production.local'
									WHEN DomainName = 'stage'	THEN '.stage.local'
									END)) [FQDN]
				,CASE WHEN SystemModel Like '%vmware%' THEN 'Virtual Server' ELSE 'Standard Server' END [ServerType]	
				,Memory	
				,SQLmax_memory	
				,FrameWork_ver	
				,SAN	
				,PowerPath	
				,IPnum
				,CPUphysical	
				,CPUcore	
				,CPUlogical	
				,CPUtype	
				,OSname	
				,OSver	
				,OSinstallDate	
				,TimeZone	
				,SystemModel	
				,Services
		FROM		[dbacentral].[dbo].[DBA_ServerInfo] T1
		WHERE		[SQLEnv] = 'Production'
			AND	[Active] != 'N'
			AND	(
				NULLIF([Cluster],'') Is Null
			OR	
				ServerName IN	(
						SELECT		ResourceName
						FROM		[dbacentral].[dbo].[DBA_ClusterInfo]
						WHERE		[ResourceType] = 'Node'
							AND	ResourceName IN (SELECT ServerName FROM [dbacentral].[dbo].[DBA_ServerInfo])
						)
				) 
		) Data


WHERE		[ServerName]  NOT IN


('ASHPAMERDC01'
,'ASHPAPACDC01'
,'ashpaspsql01'
,'ASHPASPSQL03'
,'ASHPEDSQL01'
,'ASHPEDSQL02'
,'ashpedsqlg01'
,'ashpedsqlg02'
,'ashpeftftp01'
,'ashpeftftp02'
,'ASHPEWSMEDIA01'	
,'ASHPEWSMEDIA02'	
,'ashpftpgw01'
,'ashpftpgw02'
,'ASHPGGNDC01'
,'ashpgmssql03'
,'ASHPGSYSSQL01'
,'ASHPGSYSSTMGR01'	
,'ashpprcsql01'
,'ASHPSHWSQL01'
,'ASHPSHWSQL03'
,'ASHPSQLDIST01'
,'ASHPSQLDIST02'
,'ashpsqldistg01'	
,'ashpsqldistg02'	
,'ASHPSQLTFS01'
,'ASHPWJUMP02'
,'CALPAMERDC01'
,'CALPAMERDC02'
,'CALPAMERDC05'
,'CALPCART01'
,'calpdc01'
,'CALPGSYSSTMGR01'	
,'CALPSCCMS01'
,'CHIFILEP03'
,'CHIMONXP01'
,'CHIPAMERDC01'
,'CHIPAMERDC02'
,'CHIPAMERDC02'
,'CHIPCART01'
,'CHIPGSYSSTMGR01'	
,'CHIPHPV0'
,'CHIPHPV01'
,'CHIPHPV03'
,'CHIPHPV04'
,'DALMONXP01'
,'DALPSRV01'
,'DBIPCART01'
,'DBIPEMEADC01'
,'DBIPHPV01'
,'dc1-nj2'	
,'DEVTESTDEPLOY01'	
,'DNS01'
,'DNS02'
,'DR1PGSYSCIM01'
,'DUBMONXP01'
,'DUBPCART01'
,'DUBPEMEADC01'
,'DUBPGSYSSTMGR01'	
,'DUBPHPV02'
,'FREDESTEIN01'
,'FREDGSYSCIM01'
,'FREDGSYSSQL01'
,'FREDSQLDIST01'
,'FREDSQLPERF01'
,'FREDSQLTOL01'
,'FREGYIDC01'
,'FREGYIDC02'
,'FREPAMERDC04'
,'FREPBACK01'
,'FREPBACK02'
,'FREPCOGAPP01'
,'FREPCOGAPP02'
,'FREPFS03'
,'FREPFSJUP01'
,'FREPGSYSSTMGR01'	
,'FREPHYPERAPP01'	
,'FREPHYPERAPP02'	
,'FREPHYPEROLAP01'	
,'FREPHYPEROLAP02'	
,'FREPHYPERSQL01'	
,'FREPSQLDWARCH'
,'FREPSQLEDW01'
,'FREPSQLGLB01'
,'FREPSQLRYLA01'
,'FREPSQLRYLA11'
,'FREPSQLRYLA12'
,'FREPSQLRYLA13'
,'FREPSQLRYLA14'
,'FREPSQLRYLA15'
,'FREPSQLRYLB01'
,'FREPSQLRYLB11'
,'FREPSQLRYLB12'
,'FREPSQLRYLB13'
,'FREPSQLRYLB14'
,'FREPSQLRYLB15'
,'FREPSQLRYLJ04'
,'FREPSQLRYLR01'
,'FRESDC01'
,'FRESDC02'
,'FRESEDSQL01'
,'FRESEDSQL02'
,'FRESEWSMEDIA01'	
,'FRESEWSMEDIA02'	
,'FRESSQLDIST01'
,'FRESSQLDIST02'
,'FRESSQLRYL01'
,'FRESSQLRYL11'
,'FRESSQLRYL12'
,'FRESSQLRYLi01'
,'FRESSQLTAX01'
,'FRESWINSVC01'
,'FRESWINSVC02'
,'FRETRYLABP01'
,'FRETSCOMRPTSQL1'	
,'FRETSCOMSQL01'
,'FRETSQLDIP02'
,'FRETSQLDIST01'
,'FRETSQLRYL02'
,'FRETSQLRYL03'
,'FRETSQLRYLi02'
,'FRETSQLRYLi03'
,'HERPEMEADC01'
,'HKGMONXP01'
,'HKGPAPACDC01'
,'HKGPFS01'
,'HKGPGSYSSTMGR01'	
,'integration'
,'LAXPAMERDC01'
,'LAXPBACK01'
,'LAXPCART01'
,'LAXPFIL01'
,'LAXPFIL02'
,'LAXPFS01'
,'LAXPFS02'
,'LAXPFS03'
,'LAXPGSYSSTMGR01'	
,'LAXPHPV01'
,'LAXPSCCMS11'
,'Load ASP SQL Refresh'
,'LONBACKUP'
,'LONEDIFTP'
,'LONEDIINDEX'
,'LONPAMERDC01'
,'LONPBACK02'
,'LONPCART01'
,'LONPDAC01'
,'LONPEMEADC01'
,'LONPEMEADC02'
,'LONPFS01'
,'LONPFS02'
,'LONPFS04'
,'LONPGGNDC01'
,'LONPGSYSSTMGR01'	
,'LONPGSYSSTMGR02'	
,'LONPSCOMGW01'
,'LONTHPV02'
,'LONTS01'	
,'MADDFSBO01'
,'MCLPAMERFS02'
,'MCLPCART01'
,'MCLPGSYSSTMGR01'	
,'MDRPCART01'
,'MDRPHPV03'
,'MILPCART01'
,'MUNMONXP01'
,'MUNPCART01'
,'MUNPEMEADC01'
,'MUNPGSYSSTMGR01'	
,'MUNPHPV02'
,'NetMgr1'	
,'NYCMONXP01'
,'NYCPAMERDC01'
,'NYCPAMERDC02'
,'NYCPCART01'
,'NYCPGSYSSTMGR01'	
,'NYCPSCOMGW01'
,'NYCPXCH10EXEC01'	
,'NYCVPBACK01'
,'NYCVPFIL01'
,'NYCVPFIL02'
,'NYCVPFS01'
,'NYCVPFS03'
,'NYMVSQLDEV01'
,'NYMVSQLDEV02'
,'PARMONXP01'
,'PARPCART01'
,'PARPEMEADC01'
,'PARPGSYSSTMGR01'	
,'parphpv01'
,'parphpv02'
,'PARPSCCMS20'
,'PEOPAMERPRT01'
,'pics-dc'	
,'pics-dev'
,'PROD ASP SQL 1 Refresh'	
,'Prod ASP SQL 2 Refresh'	
,'Prod-Shared-SQL02'
,'SAOPAMERDC01'
,'SEADCBLACKBRY01'	
,'SEADCLABSSQL01'	
,'SEADCPVCNTAPP01'	
,'SEADCTSNET03'
,'SEADSPICEWRK01'	
,'seadsqlryl01'
,'SEAFRESQL01'
,'SEAFRESQLBO01'
,'SEAFRESQLBO02'
,'SEAFRESQLBOT01'	
,'SEAFRESQLPROJ01'	
,'SEAFRESQLSB01'
,'SEAFRESQLTAL04'	
,'SEAPAMERDC01'
,'SEAPAMERDC02'
,'SEAPAMERDC03'
,'SEAPAMERDC04'
,'SEAPAPACDC01'
,'SEAPASPSQL01'
,'SEAPASPSQL02'
,'seapbocsql01'
,'seapbocsql02'
,'SEAPBOMGT01'
,'SEAPCOGSQL01'
,'seapcrm5web01'
,'seapcrmsql11'
,'SEAPCRMSQL12'
,'SEAPCTXAPP01'
,'SEAPCTXAPP02'
,'SEAPCTXAPP03'
,'SEAPCTXAPP04'
,'SEAPCTXAPP05'
,'SEAPCTXAPP07'
,'SEAPCTXAPP08'
,'SEAPCTXFS01'
,'SEAPCTXFS02'
,'SEAPDC03'
,'SEAPDC04'
,'SEAPDELLOME01'
,'SEAPDELWEB01'
,'SEAPDELWEB02'
,'SEAPDELWEB03'
,'SEAPDELWEB04'
,'SEAPDELWEB05'
,'SEAPDELWEB06'
,'SEAPDELWEB07'
,'SEAPDWDCSQLD01'	
,'SEAPDWDCSQLD02'	
,'SEAPDWDCSQLP01'	
,'SEAPDWDCSQLP02'	
,'SEAPDWDDIST01'
,'SEAPDWDDIST02'
,'SEAPDWDPICT04'
,'SEAPDWDSFTP01'
,'SEAPDWDSFTP02'
,'SEAPDWDTERM01'
,'SEAPDWDTERM02'
,'SEAPDWDTERM03'
,'seapedsqlg01'
,'seapedsqlg02'
,'SEAPEFTFTP01-OLD'
,'SEAPEFTFTP02-OLD'
,'SEAPEMEADC01'
,'SEAPEWSMEDIA01'	
,'SEAPEWSMEDIA02'	
,'SEAPFTPGW01'
,'SEAPFTPGW02'
,'seapftpgw02_new'	
,'SEAPGGNDC01'
,'SEAPGGNDC02'
,'SEAPGMSSQL03'
,'SEAPGMSSQL04'
,'SEAPGSYSCCA01'
,'SEAPGSYSCIM01'
,'SEAPGSYSSQL01'
,'SEAPGSYSSTMGR01'	
,'SEAPHWUSQL01'
,'seaphypapp01'
,'seaphypapp02'
,'seaphypolap01'
,'seaphypsql01'
,'SEAPLOGSQL01'
,'SEAPMONAPP01'
,'SEAPNCACHEA01'
,'SEAPPERFWEBSQL1'	
,'SEAPPERFWEBSQL2'	
,'seapprcsql01'
,'SEAPSAS01'
,'SEAPSCCMC01'
,'SEAPSCCMC10'
,'SEAPSCCMP01'
,'SEAPSCOMGW01'
,'SEAPSCOMGW02'
,'SEAPSCOMGW05'
,'SEAPSCOMGW06'
,'SEAPSCOMMS01'
,'SEAPSCOMMS02'
,'SEAPSCOMMS03'
,'SEAPSCOMMS04'
,'SEAPSCOMMS06'
,'SEAPSCOMMS07'
,'SEAPSCOMRMS01'
,'SEAPSCOMRMS01'
,'SEAPSCOMRPT01'
,'SEAPSCOMSQL01'
,'SEAPSCOMSQL02'
,'SEAPSCOMSQLDW01'	
,'SEAPSCOMSQLDW02'	
,'seapsdtsql01'
,'seapsdtsql02'
,'SEAPSECAPP01'
,'SEAPSECAPP02'
,'SEAPSECDB01'
,'SEAPSHAREWEB01'	
,'SEAPSHAREWEB02'	
,'SEAPSHWSQL01'
,'SEAPSHWSQL02'
,'SEAPSMTP01'
,'SEAPSMTP02'
,'SEAPSQLBO01'
,'SEAPSQLBO02'
,'SEAPSQLDBA01'
,'SEAPSQLDIP01'
,'seapsqldistg01'	
,'seapsqldistg02'	
,'SEAPSQLDPLY01'
,'SEAPSQLDPLY02'
,'SEAPSQLDPLY05'
,'SEAPSQLLSHP01'
,'SEAPSQLMVINT01'	
,'seapsqlrpt01'
,'seapsqlryl01'
,'seapsqlryl02'
,'SEAPSQLRYLI01'
,'seapsqlrylprc01'	
,'seapsqlrylprc02'	
,'SEAPSQLSHR21'
,'SEAPSQLSHR22'
,'SEAPSQLSPS01'
,'SEAPSQLSPS02'
,'SEAPSQLTAX01'
,'SEAPSQLTAX02'
,'SEAPSQLTFS01'
,'SEAPSQLTFS02'
,'SEAPSTKAPP01'
,'SEAPSTKAPP02'
,'SEAPTMG01'
,'SEAPTMG02'
,'seapuinmage05'
,'SEAPVCENT01'
,'SEAPWEBMAN01'
,'SEAPWINSVC01'
,'SEAPWINSVC02'
,'SEASCRMSQL01'
,'SEASCRMSQL12'
,'seasedsql01'
,'seasedsql02'
,'SEASINTWINSVC01'	
,'SEASINTWINSVC02'	
,'seassdtsql01'
,'seassdtsql02'
,'SEASSQLBOB01'
,'seassqlboc01'
,'seassqldist01'
,'seassqldist02'
,'seassqlryl01'
,'SEASSQLRYLi01'
,'SEASSQLRYLi02'
,'seassqlrylprc01'	
,'seassqlrylprc02'	
,'SEASTGSQLA01'
,'SEASTGSQLA02'
,'SEATCRM5SQL01'
,'seatgeosql01'
,'seatgeosql02'
,'seatpocsofs01'
,'seatpocsofs02'
,'seatsqlryl01'
,'Server (Windows)'
,'Shared-SQL-Prod-01-Refresh'
,'SNGMONXP01'
,'SNGPAPACDC01'
,'SNGPCART01'
,'SNGPFS01'
,'SNGPGSYSSTMGR01'	
,'SNGPHPV01'
,'SQLDEPLOYER02'
,'SQLDEPLOYER04'
,'Stage ASP SQL Refresh'
,'SYDMONXP01'
,'SYDPAPACDC01'
,'SYDPAPACDC02'
,'SYDPBACK01'
,'SYDPCART01'
,'Sydpdfs01'
,'SYDPFS01'
,'SYDPFTP01'
,'SYDPGGNDC01'
,'SYDPGSYSSTMGR01'	
,'SYDPICDESK01'
,'SYDSECURE'
,'SYDXCHFE02'
,'tfs'
,'TOKFILE02'
,'TOKMONXP01'
,'TOKPAPACDC01'
,'TOKPCART01'
,'TOKPGSYSSTMGR01'	
,'tokphpv01'
,'UCS B200 M3 Blade'
,'UCS B200 M3 Blade'
,'UCS B200 M3 Blade'
,'UCS B230 M2 Blade'
,'UCS B230 M2 Blade'
,'UCS B230 M2 Blade'
,'UCS B230 M2 Blade'
,'UCS B230 M2 Blade'
,'UCS B230 M2 Blade'
,'UCS B230 M2 Blade'
,'UCS B230 M2 Blade'
,'adisql02'
,'adisql03'
,'adisql04'
,'ash-qa2-mysqlmonitor1'
,'ash-vdb-mysqlmonitor1'
,'ashpacmmysql01'
,'ashpacmmysql02'
,'ASHPCOLBSQL01'
,'ASHPCRMSQL11'
,'ASHPIDMSQL01'
,'ASHPMYSQLRPT02'
,'ASHPMYSQLRPT02'
,'ASHPNOESQL01'
,'ASHPSQLEDW01'
,'ASHPSQLEDW02'
,'ASHPSQLEDWLOG01'
,'ASHPSQLEDWLOG02'
,'ashptaxsql01'
,'ASHPTAXSQLC01'
,'ASHPTAXSQLC01'
,'ASHPTAXSQLC02'
,'ASHTSQLAG01'
,'ashtsqlag02'
,'ASHTSQLWCDS01'
,'brian-mysql4'
,'calpacmmysql01'
,'calpacmmysql02'
,'cf-mysql-sandbox'
,'fizzbuzz-mysql'
,'FREBCTBSQL01'
,'FREBGMSSQLA01'
,'FREBGMSSQLB01'
,'FREBPCXSQL01'
,'FRECCTBSQL01'
,'frecgmssqla01'
,'frecgmssqlb01'
,'frecpcxsql01'
,'FREDLABSSQL01'
,'FREDSQLTAX01'
,'FREDSRSSQL01'
,'FRELLNPSQL01'
,'FREPSQLNOE01'
,'freptssql01'
,'FREPVARSQL01'
,'fresuipwmysql01'
,'FRETHYPERSQL01'
,'FRETSQLCTX01'
,'FRETSQLDBA01'
,'FRETSQLNOE01'
,'FRETSQLTAX01'
,'FRETSQLTAX01'
,'GMSSQLDEV01'
,'GMSSQLDEV04'
,'GMSSQLLOAD02'
,'GMSSQLTEST01'
,'GMSSQLTEST03'
,'jon-mysql'
,'json-sql-test'
,'PCSQLDEV01'
,'PCSQLDEV04'
,'PCSQLLOAD02'
,'PCSQLTEST01'
,'PCSQLTEST03'
,'sea-prod-gettywiki-sql-01'
,'sea-prod-gettywiki-sql-02'
,'sea-prod-infobank-sql-01'
,'sea-prod-mysql-mem-01'
,'sea-prod-nycreative-mysql-01'
,'seabachsql01'
,'SEABCRM5SQL01'
,'SEABEDSQL01'
,'SEABSCFWSQL01'
,'SEABSQLDIST01'
,'SEABSSSQL01'
,'seacachsql01'
,'SEACACMMYSQL01'
,'SEACCOLSQL01'
,'SEACCRM5SQL01'
,'SEACEDSQL01'
,'SEACSCFWSQL01'
,'SEACSQLDIST01'
,'SEACSSSQL01'
,'SEADIDMSQL01'
,'SEADROYSQL02'
,'SEADSDTSQLA02'
,'SEADSDTSQLB02'
,'SEADSPSSQL01'
,'SEADSQLBOB01'
,'SEADSQLIDM01'
,'SEADSQLIDM01'
,'SEADSQLIDM02'
,'SEADSQLRYLPMT01'
,'SEADSQLRYLPRC01'
,'SEADSSSQL01'
,'SEADTAXSQL01'
,'seaduaipmysql01'
,'SEALACHSQL02'
,'SEALASPSQL01'
,'SEALCOLSQL01'
,'SEALCOLSQL02'
,'SEALSCFWSQL02'
,'SEALSSSQL01'
,'SEALSSSQL02'
,'SEAPACMMYSQL01'
,'SEAPACMMYSQL02'
,'SEAPCOLBSQL01'
,'SEAPCOLBSQL02'
,'SEAPCSOSQL01'
,'SEAPDBASQL01'
,'SEAPDBASQL02'
,'SeapFinsql01'
,'SEAPIDMSQL01'
,'SEAPIDMSQL02'
,'SeaplyncSQL01'
,'SEAPMYSQLRPT01'
,'SEAPMYSQLRPT01 (2)'
,'SEAPMYSQLRPT02'
,'SEAPRPTMYSQL01'
,'SEAPRPTSQL01'
,'SEAPSQLBOD'
,'SEAPSQLBOE'
,'seapsqlcso01'
,'SEAPSQLCTX01'
,'SEAPSQLDPLY03'
,'SEAPSQLDPLY04'
,'SEAPSQLEDW01'
,'SEAPSQLEDW02'
,'SEAPSQLEDWLOG01_decommed'
,'SEAPSQLEDWLOG02'
,'SEAPSQLEDWLOG03'
,'SEAPSQLEDWLOG04'
,'SEAPSQLEDWLOG05'
,'SEAPSQLIBMDIR'
,'SEAPSQLLYNC01'
,'SEAPSQLOPS01'
,'SEAPSQLRYL03'
,'SEAPSQLRYLDST01'
,'SEAPSQLRYLINT02'
,'SEAPSQLRYLJ02'
,'SEAPSQLRYLJ04'
,'SEAPSQLRYLJ04'
,'SEAPSQLRYLPMT01'
,'SEAPSQLRYLRPT01'
,'SEAPSQLSP1301'
,'SEAPSQLWBS0A'
,'SEAPTAXSQLC01'
,'SEAPTAXSQLC02'
,'seapualappmysql01'
,'seapualappmysql02'
,'seapuipwmysql01'
,'seapuipwmysql02'
,'seapumysqldba01'
,'seapvcentsql01'
,'seasacmmysql01'
,'seasacmmysql02'
,'SEASCOLBSQL01'
,'SEASCOLBSQL02'
,'SEASDBASQL01'
,'SEASHYPSQL01'
,'SEASSQLRYLIB01'
,'SEASSQLRYLIB02'
,'SEASSQLRYLPMT01'
,'SEASSQLRYLPRC01'
,'SEASSQLRYLPRC02'
,'SEASSQLRYLRPT01'
,'SEASTAXSQLC01'
,'SEASTAXSQLC02'
,'SEASUMYSQL05'
,'SEASUMYSQL06'
,'SEATACHSQL01'
,'SEATASPSQL01'
,'SEATCOLSQL01'
,'SEATCOLSQL03'
,'SEATCOLSQL03 (2)'
,'SEATCSOSQL02'
,'seatrhzsql01'
,'SEATROYSQL01'
,'SEATSCFWSQL01'
,'SEATSCFWSQL01'
,'SEATSCFWSQL03'
,'SEATSDTSQLA01'
,'SEATSDTSQLA02'
,'SEATSDTSQLB01'
,'SEATSDTSQLB02'
,'SEATSHPSQL01'
,'SEATSQL2014POC4'
,'SEATSQLAG01'
,'SEATSQLAG02'
,'SEATSQLBOB01'
,'SEATSQLDBA01'
,'SEATSQLPUP01'
,'SEATSQLRYLPMT01'
,'SEATSQLRYLPRC01'
,'SEATSSSQL01'
,'SEATSSSQL03'
,'SEATTAXSQL01'
,'seatualappmysql01'
,'seatualappmysql02'
,'seatualasrmysql01'
,'Seavmsqldwftst1'
,'sql01'
,'sql02'
,'sqlpackagetest'
,'sqlpackagetest'
,'vcac-iaas-sql'
,'vcac-iaas-sql-reclaim'
)


ORDER BY	5,2



