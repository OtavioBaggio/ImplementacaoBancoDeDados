BEGIN TRY
	print 'Ola mundo!' --> funciona
	select 1/0;		   --> erro
	print 'N�o cheguei aqui'
END TRY
BEGIN CATCH
	print 'DEU ERRO!';
	print 'N�mero: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
	print 'Mensagem: ' + ERROR_MESSAGE();
END CATCH