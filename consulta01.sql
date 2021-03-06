USE jardin;
-- CONSULTA UNO

SELECT EDIFICIO.EDIFICIO_ID AS edificioIde,
       EDIFICIO.EDIFICIO_NOMBRE AS edificioNombre,
       COUNT(SALA.EDIFICIO_ID) as edificioSalaCantidad
FROM EDIFICIO JOIN SALA ON SALA.EDIFICIO_ID = EDIFICIO.EDIFICIO_ID
GROUP BY EDIFICIO.EDIFICIO_ID;

-- CONSULTA DOS

SELECT 
    ENFERMEDAD.ENFER_ID AS enfermedadIde,
    ENFERMEDAD.ENFER_NOMBRE enfermedadNombre,
    COUNT(ENFERMEDAD_CURSO_ALUMNO.ENFER_ID) enfermedadCantidad
FROM
    ENFERMEDAD
        JOIN
    ENFERMEDAD_CURSO_ALUMNO ON ENFERMEDAD_CURSO_ALUMNO.ENFER_ID = ENFERMEDAD.ENFER_ID
GROUP BY ENFERMEDAD.ENFER_ID
ORDER BY COUNT(ENFERMEDAD_CURSO_ALUMNO.ENFER_ID) DESC;

-- CONSULTA TRES
SELECT
	TIPO_INASISTENCIA.TA_ID as inasistenciaTipoIde,
    TIPO_INASISTENCIA.TA_NOMBRE as inasistenciaTipoNombre,
    COUNT(INASISTENCIA.TA_ID) as inasistenciaCantidad
FROM
	TIPO_INASISTENCIA
JOIN
	INASISTENCIA ON INASISTENCIA.TA_ID = TIPO_INASISTENCIA.TA_ID
GROUP BY INASISTENCIA.TA_ID;
-- CONSULTA CUATRO
SELECT 
    APODERADO.APO_RUT AS apoderadoRut,
    APODERADO.APO_NOMBRE AS apoderadoNombre,
    COUNT(APAL.ALUMNO_RUT) AS apoderadoCantidadAlumno
FROM
    APODERADO
        JOIN
    APAL ON APAL.APO_RUT = APODERADO.APO_RUT
GROUP BY APODERADO.APO_RUT;
-- CONSULTA CINCO
SELECT 
    ALUMNO.ALUMNO_RUT AS alumnoRut,
    CONCAT(ALUMNO.ALUMNO_NOMBRE,
            ' ',
            ALUMNO.ALUMNO_APATERNO,
            ' ',
            ALUMNO.ALUMNO_AMATERNO) AS alumnoNombre,
    CURSO.CURSO_NOMBRE AS cursoNombre,
    CONCAT(APODERADO.APO_NOMBRE,
            ' ',
            APODERADO.APO_APATERNO,
            ' ',
            APODERADO.APO_AMATERNO) AS apoderadoNombre
FROM
    ALUMNO
        JOIN
    CURSO_ALUMNO ON CURSO_ALUMNO.ALUMNO_RUT = ALUMNO.ALUMNO_RUT
        JOIN
    CURSO ON CURSO.CURSO_ID = CURSO_ALUMNO.CURSO_ID
        JOIN
    APAL ON APAL.ALUMNO_RUT = ALUMNO.ALUMNO_RUT
        JOIN
    APODERADO ON APODERADO.APO_RUT = APAL.APO_RUT;
-- CONSULTA SEIS
SELECT 
    ENFERMEDAD.ENFER_NOMBRE AS enfermedadNombre,
    DATE_FORMAT(ENFERMEDAD_CURSO_ALUMNO.ECA_FECHA_INICIO,
            '%d/%m/%Y') AS enfermedadFechaInicio,
    DATE_FORMAT(ENFERMEDAD_CURSO_ALUMNO.ECA_FECHA_FIN,
            '%d/%m/%Y') AS enfermedadFechaTermino,
    CURSO.CURSO_NOMBRE AS cursoNombre,
    ALUMNO.ALUMNO_RUT AS alumnoRut,
    CONCAT(ALUMNO.ALUMNO_NOMBRE,
            ' ',
            ALUMNO.ALUMNO_APATERNO,
            ' ',
            ALUMNO.ALUMNO_AMATERNO) AS alumnoNombre
FROM
    ENFERMEDAD
        JOIN
    ENFERMEDAD_CURSO_ALUMNO ON ENFERMEDAD_CURSO_ALUMNO.ENFER_ID = ENFERMEDAD.ENFER_ID
        JOIN
    CURSO_ALUMNO ON CURSO_ALUMNO.CA_ID = ENFERMEDAD_CURSO_ALUMNO.CA_ID
        JOIN
    CURSO ON CURSO.CURSO_ID = CURSO_ALUMNO.CURSO_ID
        JOIN
    ALUMNO ON ALUMNO.ALUMNO_RUT = CURSO_ALUMNO.ALUMNO_RUT
WHERE
    ENFERMEDAD.ENFER_CONTAGIOSA = 1
ORDER BY ENFERMEDAD_CURSO_ALUMNO.ECA_FECHA_INICIO ASC;
-- CONSULTA SIETE
SELECT
	CURSO.CURSO_NOMBRE as cursoNombre,
    ALUMNO.ALUMNO_RUT AS alumnoRut,
    CONCAT(ALUMNO.ALUMNO_NOMBRE,
            ' ',
            ALUMNO.ALUMNO_APATERNO,
            ' ',
            ALUMNO.ALUMNO_AMATERNO) AS alumnoNombre,    
    DATE_FORMAT(INASISTENCIA.INA_FECHA, '%d/%m/%Y') AS inasistenciaFecha,
    TIPO_INASISTENCIA.TA_NOMBRE as inasistenciaMotivo
FROM
    INASISTENCIA
JOIN
	TIPO_INASISTENCIA ON TIPO_INASISTENCIA.TA_ID = INASISTENCIA.TA_ID
JOIN
	CURSO_ALUMNO ON CURSO_ALUMNO.CA_ID = INASISTENCIA.CA_ID
JOIN
	CURSO ON CURSO.CURSO_ID = CURSO_ALUMNO.CURSO_ID
        JOIN
    ALUMNO ON ALUMNO.ALUMNO_RUT = CURSO_ALUMNO.ALUMNO_RUT    
WHERE
    INASISTENCIA.INA_JUSTIFICADA = 0
ORDER BY INASISTENCIA.INA_FECHA ASC;
-- CONSULTA OCHO
SELECT
	NIVEL.NIVEL_NOMBRE as nivelNombre,
	CURSO.CURSO_NOMBRE as cursoNombre,
	CURSO.CURSO_AGNO as cursoAnio,
    COUNT(CURSO_ALUMNO.ALUMNO_RUT) as cursoCantidadAlumno
FROM
	CURSO
JOIN
	NIVEL ON NIVEL.NIVEL_ID = CURSO.NIVEL_ID
JOIN
	CURSO_ALUMNO ON CURSO_ALUMNO.CURSO_ID = CURSO.CURSO_ID
GROUP BY CURSO.CURSO_ID
ORDER BY NIVEL.NIVEL_ID DESC, CURSO.CURSO_NOMBRE DESC, CURSO.CURSO_AGNO DESC;
-- CONSULTA NUEVE
SELECT
    ALUMNO.ALUMNO_RUT AS alumnoRut,
    CONCAT(ALUMNO.ALUMNO_NOMBRE,
            ' ',
            ALUMNO.ALUMNO_APATERNO,
            ' ',
            ALUMNO.ALUMNO_AMATERNO) AS alumnoNombre,
	COUNT(INASISTENCIA.INA_ID) as inasistenciaCantidad
FROM
	ALUMNO
JOIN
	CURSO_ALUMNO ON CURSO_ALUMNO.ALUMNO_RUT = ALUMNO.ALUMNO_RUT
JOIN
	INASISTENCIA ON INASISTENCIA.CA_ID = CURSO_ALUMNO.CA_ID
GROUP BY ALUMNO.ALUMNO_RUT
ORDER BY COUNT(INASISTENCIA.INA_ID);
-- CONSULTA DIEZ
SELECT
    ALUMNO.ALUMNO_RUT AS alumnoRut,
    CONCAT(ALUMNO.ALUMNO_NOMBRE,
            ' ',
            ALUMNO.ALUMNO_APATERNO,
            ' ',
            ALUMNO.ALUMNO_AMATERNO) AS alumnoNombre,
	COUNT(ENFERMEDAD_CURSO_ALUMNO.ENFER_ID) as enfermedadCantidad            
FROM
	ALUMNO
JOIN
	CURSO_ALUMNO ON CURSO_ALUMNO.ALUMNO_RUT = ALUMNO.ALUMNO_RUT    
JOIN
	ENFERMEDAD_CURSO_ALUMNO ON ENFERMEDAD_CURSO_ALUMNO.CA_ID = CURSO_ALUMNO.CA_ID
GROUP BY ALUMNO.ALUMNO_RUT
ORDER BY COUNT(ENFERMEDAD_CURSO_ALUMNO.ENFER_ID) DESC;