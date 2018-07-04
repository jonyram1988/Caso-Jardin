/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     11-06-2018 15:53:21                          */
/*==============================================================*/


drop table if exists ALUMNO;

drop table if exists APAL;

drop table if exists APAL_CA;

drop table if exists APODERADO;

drop table if exists CURSO;

drop table if exists CURSO_ALUMNO;

drop table if exists EDIFICIO;

drop table if exists ENFERMEDAD;

drop table if exists ENFERMEDAD_CURSO_ALUMNO;

drop table if exists INASISTENCIA;

drop table if exists NIVEL;

drop table if exists PARENTEZCO;

drop table if exists SALA;

drop table if exists TIPO_INASISTENCIA;

/*==============================================================*/
/* Table: ALUMNO                                                */
/*==============================================================*/
create table ALUMNO
(
   ALUMNO_RUT           char(13) not null,
   ALUMNO_NOMBRE        varchar(25),
   ALUMNO_APATERNO      varchar(25),
   ALUMNO_AMATERNO      varchar(25),
   primary key (ALUMNO_RUT)
);

/*==============================================================*/
/* Table: APAL                                                  */
/*==============================================================*/
create table APAL
(
   APAL_ID              int not null,
   ALUMNO_RUT           char(13),
   APO_RUT              char(13),
   PARENTEZO_ID         int,
   primary key (APAL_ID)
);

/*==============================================================*/
/* Table: APAL_CA                                               */
/*==============================================================*/
create table APAL_CA
(
   APAL_ID              int not null,
   CA_ID                int not null,
   primary key (APAL_ID, CA_ID)
);

/*==============================================================*/
/* Table: APODERADO                                             */
/*==============================================================*/
create table APODERADO
(
   APO_RUT              char(13) not null,
   APO_NOMBRE           varchar(25),
   APO_APATERNO         varchar(25),
   APO_AMATERNO         varchar(25),
   APO_FONO             varchar(25),
   APO_EMAIL            varchar(25),
   APO_DIRECCION        varchar(25),
   primary key (APO_RUT)
);

/*==============================================================*/
/* Table: CURSO                                                 */
/*==============================================================*/
create table CURSO
(
   CURSO_ID             int not null,
   SALA_ID              int,
   NIVEL_ID             int,
   CURSO_NOMBRE         varchar(25),
   CURSO_AGNO           int,
   primary key (CURSO_ID)
);

/*==============================================================*/
/* Table: CURSO_ALUMNO                                          */
/*==============================================================*/
create table CURSO_ALUMNO
(
   CA_ID                int not null,
   ALUMNO_RUT           char(13),
   CURSO_ID             int,
   primary key (CA_ID)
);

/*==============================================================*/
/* Table: EDIFICIO                                              */
/*==============================================================*/
create table EDIFICIO
(
   EDIFICIO_ID          int not null,
   EDIFICIO_NOMBRE      varchar(25),
   primary key (EDIFICIO_ID)
);

/*==============================================================*/
/* Table: ENFERMEDAD                                            */
/*==============================================================*/
create table ENFERMEDAD
(
   ENFER_ID             int not null,
   ENFER_NOMBRE         varchar(25),
   ENFER_CONTAGIOSA     bool,
   primary key (ENFER_ID)
);

/*==============================================================*/
/* Table: ENFERMEDAD_CURSO_ALUMNO                               */
/*==============================================================*/
create table ENFERMEDAD_CURSO_ALUMNO
(
   ECA_ID               int not null,
   ENFER_ID             int,
   CA_ID                int,
   ECA_FECHA_INICIO     date,
   ECA_FECHA_FIN        date,
   primary key (ECA_ID)
);

/*==============================================================*/
/* Table: INASISTENCIA                                          */
/*==============================================================*/
create table INASISTENCIA
(
   INA_ID               int not null,
   CA_ID                int,
   TA_ID                int,
   INA_FECHA            date,
   INA_JUSTIFICADA      bool,
   primary key (INA_ID)
);

/*==============================================================*/
/* Table: NIVEL                                                 */
/*==============================================================*/
create table NIVEL
(
   NIVEL_ID             int not null,
   NIVEL_NOMBRE         varchar(25),
   primary key (NIVEL_ID)
);

/*==============================================================*/
/* Table: PARENTEZCO                                            */
/*==============================================================*/
create table PARENTEZCO
(
   PARENTEZO_ID         int not null,
   PARECTEZCO_NOMBRE    varchar(25),
   primary key (PARENTEZO_ID)
);

/*==============================================================*/
/* Table: SALA                                                  */
/*==============================================================*/
create table SALA
(
   SALA_ID              int not null,
   EDIFICIO_ID          int,
   SALA_NOMBRE          varchar(25),
   primary key (SALA_ID)
);

/*==============================================================*/
/* Table: TIPO_INASISTENCIA                                     */
/*==============================================================*/
create table TIPO_INASISTENCIA
(
   TA_ID                int not null,
   TA_NOMBRE            varchar(25),
   primary key (TA_ID)
);

alter table APAL add constraint FK_APALAL foreign key (ALUMNO_RUT)
      references ALUMNO (ALUMNO_RUT) on delete restrict on update restrict;

alter table APAL add constraint FK_APALAP foreign key (APO_RUT)
      references APODERADO (APO_RUT) on delete restrict on update restrict;

alter table APAL add constraint FK_PAPAL foreign key (PARENTEZO_ID)
      references PARENTEZCO (PARENTEZO_ID) on delete restrict on update restrict;

alter table APAL_CA add constraint FK_APAL_CA foreign key (APAL_ID)
      references APAL (APAL_ID) on delete restrict on update restrict;

alter table APAL_CA add constraint FK_APAL_CA2 foreign key (CA_ID)
      references CURSO_ALUMNO (CA_ID) on delete restrict on update restrict;

alter table CURSO add constraint FK_CN foreign key (NIVEL_ID)
      references NIVEL (NIVEL_ID) on delete restrict on update restrict;

alter table CURSO add constraint FK_SC foreign key (SALA_ID)
      references SALA (SALA_ID) on delete restrict on update restrict;

alter table CURSO_ALUMNO add constraint FK_ACA foreign key (ALUMNO_RUT)
      references ALUMNO (ALUMNO_RUT) on delete restrict on update restrict;

alter table CURSO_ALUMNO add constraint FK_CAC foreign key (CURSO_ID)
      references CURSO (CURSO_ID) on delete restrict on update restrict;

alter table ENFERMEDAD_CURSO_ALUMNO add constraint FK_CAE foreign key (CA_ID)
      references CURSO_ALUMNO (CA_ID) on delete restrict on update restrict;

alter table ENFERMEDAD_CURSO_ALUMNO add constraint FK_EECA foreign key (ENFER_ID)
      references ENFERMEDAD (ENFER_ID) on delete restrict on update restrict;

alter table INASISTENCIA add constraint FK_CAI foreign key (CA_ID)
      references CURSO_ALUMNO (CA_ID) on delete restrict on update restrict;

alter table INASISTENCIA add constraint FK_ITA foreign key (TA_ID)
      references TIPO_INASISTENCIA (TA_ID) on delete restrict on update restrict;

alter table SALA add constraint FK_SE foreign key (EDIFICIO_ID)
      references EDIFICIO (EDIFICIO_ID) on delete restrict on update restrict;

