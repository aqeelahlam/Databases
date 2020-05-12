-- Generated by Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   at:        2020-05-12 21:34:48 MYT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g

-- Student ID: 29262674
-- Student Name: Aqeel Ahlam Rauf


set echo on
spool mau_schema_output.txt

DROP TABLE artist CASCADE CONSTRAINTS;

DROP TABLE artwork CASCADE CONSTRAINTS;

DROP TABLE current_status CASCADE CONSTRAINTS;

DROP TABLE customer CASCADE CONSTRAINTS;

DROP TABLE exhibition CASCADE CONSTRAINTS;

DROP TABLE gallery CASCADE CONSTRAINTS;

DROP TABLE media_description CASCADE CONSTRAINTS;

DROP TABLE sale CASCADE CONSTRAINTS;

DROP TABLE style CASCADE CONSTRAINTS;

CREATE TABLE artist (
    artist_code               NUMBER(5) NOT NULL,
    artist_name               VARCHAR2(50) NOT NULL,
    artist_address            VARCHAR2(50) NOT NULL,
    artist_telephone_number   CHAR(10),
    artist_no_of_work         NUMBER(5) NOT NULL
);

COMMENT ON COLUMN artist.artist_code IS
    'Artist Code';

COMMENT ON COLUMN artist.artist_name IS
    'Artist Name';

COMMENT ON COLUMN artist.artist_address IS
    'Artist Address';

COMMENT ON COLUMN artist.artist_telephone_number IS
    'Artist Telephone Number';

COMMENT ON COLUMN artist.artist_no_of_work IS
    'Artist Number of Works';

ALTER TABLE artist ADD CONSTRAINT artist_pk PRIMARY KEY ( artist_code );

CREATE TABLE artwork (
    artist_code                   NUMBER(5) NOT NULL,
    artwork_no                    NUMBER(4) NOT NULL,
    artwork_title                 VARCHAR2(50) NOT NULL,
    artwork_date_added_to_stock   DATE NOT NULL,
    artwork_minimum_price         NUMBER(10, 2) NOT NULL,
    style_artwork                 VARCHAR2(30) NOT NULL,
    media_id                      NUMBER(5) NOT NULL
);

ALTER TABLE artwork ADD CONSTRAINT chk_art_min_price CHECK ( artwork_minimum_price
> 0 );

COMMENT ON COLUMN artwork.artist_code IS
    'Artist Code';

COMMENT ON COLUMN artwork.artwork_no IS
    'Artwork Number';

COMMENT ON COLUMN artwork.artwork_title IS
    'Artwork Title';

COMMENT ON COLUMN artwork.artwork_date_added_to_stock IS
    'The date in which the artwork was accepted into MAU';

COMMENT ON COLUMN artwork.artwork_minimum_price IS
    'Artwork Minimum Price';

COMMENT ON COLUMN artwork.style_artwork IS
    'Child/Parent Style';

COMMENT ON COLUMN artwork.media_id IS
    'Surrogate Key: Media ID';

ALTER TABLE artwork ADD CONSTRAINT artwork_pk PRIMARY KEY ( artwork_no,
                                                            artist_code );

CREATE TABLE current_status (
    artwork_no          NUMBER(4) NOT NULL,
    artist_code         NUMBER(5) NOT NULL,
    cs_date             DATE NOT NULL,
    cs_artwork_status   VARCHAR2(30) NOT NULL,
    gallery_id          NUMBER(4)
);

ALTER TABLE current_status
    ADD CONSTRAINT "ARTWORK STATUS VALUES" CHECK ( cs_artwork_status IN (
        'In MAU Warehouse',
        'In Transit',
        'On Display by Gallery',
        'Returned to the Artist',
        'Sold'
    ) );

COMMENT ON COLUMN current_status.artwork_no IS
    'Artwork Number';

COMMENT ON COLUMN current_status.artist_code IS
    'Artist Code';

COMMENT ON COLUMN current_status.cs_date IS
    'Current Status Date';

COMMENT ON COLUMN current_status.cs_artwork_status IS
    'Artwork Status';

COMMENT ON COLUMN current_status.gallery_id IS
    'Gallery ID';

ALTER TABLE current_status
    ADD CONSTRAINT current_status_pk PRIMARY KEY ( cs_date,
                                                   artwork_no,
                                                   artist_code );

CREATE TABLE customer (
    customer_id              NUMBER(5) NOT NULL,
    customer_name            VARCHAR2(50) NOT NULL,
    customer_address         VARCHAR2(50) NOT NULL,
    customer_phone           CHAR(10) NOT NULL,
    customer_business_name   VARCHAR2(50)
);

COMMENT ON COLUMN customer.customer_id IS
    'Customer ID';

COMMENT ON COLUMN customer.customer_name IS
    'Customer Name';

COMMENT ON COLUMN customer.customer_address IS
    'Customer Address';

COMMENT ON COLUMN customer.customer_phone IS
    'Customer Phone Number';

COMMENT ON COLUMN customer.customer_business_name IS
    'Customer Business Name';

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customer_id );

CREATE TABLE exhibition (
    exhibition_no                    NUMBER(5) NOT NULL,
    artwork_no                       NUMBER(4) NOT NULL,
    artist_code                      NUMBER(5) NOT NULL,
    exhibition_date_started          DATE NOT NULL,
    exhibition_date_ended            DATE,
    exhibition_featured_in_catalog   VARCHAR2(3) NOT NULL,
    gallery_id                       NUMBER(4) NOT NULL
);

ALTER TABLE exhibition
    ADD CONSTRAINT values_featured_in_catalog CHECK ( exhibition_featured_in_catalog
    IN (
        'No',
        'Yes'
    ) );

COMMENT ON COLUMN exhibition.exhibition_no IS
    'Surrogate Key: Exhibition Number';

COMMENT ON COLUMN exhibition.artwork_no IS
    'Artwork Number';

COMMENT ON COLUMN exhibition.artist_code IS
    'Artist Code';

COMMENT ON COLUMN exhibition.exhibition_date_started IS
    'Date Exhibition Started';

COMMENT ON COLUMN exhibition.exhibition_date_ended IS
    'Date Exhibition Ended';

COMMENT ON COLUMN exhibition.exhibition_featured_in_catalog IS
    'Exhibition Featured in Catalog';

COMMENT ON COLUMN exhibition.gallery_id IS
    'Gallery ID';

ALTER TABLE exhibition ADD CONSTRAINT exhibition_pk PRIMARY KEY ( exhibition_no )
;

ALTER TABLE exhibition
    ADD CONSTRAINT nk_exhibition UNIQUE ( exhibition_date_started,
                                          artwork_no,
                                          artist_code );

CREATE TABLE gallery (
    gallery_id                     NUMBER(4) NOT NULL,
    gallery_name                   VARCHAR2(50) NOT NULL,
    gallery_manager                VARCHAR2(50) NOT NULL,
    gallery_street                 VARCHAR2(50) NOT NULL,
    gallery_town                   VARCHAR2(20) NOT NULL,
    gallery_state                  VARCHAR2(20) NOT NULL,
    gallery_contact                CHAR(10) NOT NULL,
    gallery_open                   DATE NOT NULL,
    gallery_close                  DATE NOT NULL,
    gallery_percentage_comission   NUMBER(3, 2) NOT NULL
);

ALTER TABLE gallery ADD CONSTRAINT chk_gl_percentage_comission CHECK ( gallery_percentage_comission
> 0 );

COMMENT ON COLUMN gallery.gallery_id IS
    'Gallery ID';

COMMENT ON COLUMN gallery.gallery_name IS
    'Gallery Name';

COMMENT ON COLUMN gallery.gallery_manager IS
    'Name of the Gallery Manager';

COMMENT ON COLUMN gallery.gallery_street IS
    'Gallery Street';

COMMENT ON COLUMN gallery.gallery_town IS
    'Gallery Town';

COMMENT ON COLUMN gallery.gallery_state IS
    'Gallery State';

COMMENT ON COLUMN gallery.gallery_contact IS
    'Gallery Contact Number';

COMMENT ON COLUMN gallery.gallery_open IS
    'Gallery Open Time';

COMMENT ON COLUMN gallery.gallery_close IS
    'Gallery Close Time';

COMMENT ON COLUMN gallery.gallery_percentage_comission IS
    'Gallery Percentage Comission(In Percentage)';

ALTER TABLE gallery ADD CONSTRAINT gallery_pk PRIMARY KEY ( gallery_id );

CREATE TABLE media_description (
    media_id            NUMBER(5) NOT NULL,
    media_description   VARCHAR2(50)
);

COMMENT ON COLUMN media_description.media_id IS
    'Surrogate Key: Media ID';

COMMENT ON COLUMN media_description.media_description IS
    'Artwork Media Description (Material its made from)';

ALTER TABLE media_description ADD CONSTRAINT media_description_pk PRIMARY KEY ( media_id
);

CREATE TABLE sale (
    sale_id         NUMBER(5) NOT NULL,
    sale_date       DATE NOT NULL,
    sale_price      NUMBER(10, 2),
    customer_id     NUMBER(5) NOT NULL,
    exhibition_no   NUMBER(5) NOT NULL
);

ALTER TABLE sale ADD CONSTRAINT chk_sl_sale_price CHECK ( sale_id > 0 );

COMMENT ON COLUMN sale.sale_id IS
    'Sale ID';

COMMENT ON COLUMN sale.sale_date IS
    'Sale Date';

COMMENT ON COLUMN sale.sale_price IS
    'Sale Price';

COMMENT ON COLUMN sale.customer_id IS
    'Customer ID';

COMMENT ON COLUMN sale.exhibition_no IS
    'Surrogate Key: Exhibition Number';

CREATE UNIQUE INDEX sale__idx ON
    sale (
        exhibition_no
    ASC );

ALTER TABLE sale ADD CONSTRAINT sale_pk PRIMARY KEY ( sale_id );

CREATE TABLE style (
    style_artwork   VARCHAR2(30) NOT NULL,
    style_parent    VARCHAR2(30),
    art_style       VARCHAR2(30)
);

COMMENT ON COLUMN style.style_artwork IS
    'Child/Parent Style';

COMMENT ON COLUMN style.style_parent IS
    'Parent Style';

COMMENT ON COLUMN style.art_style IS
    'Child/Parent Style';

ALTER TABLE style ADD CONSTRAINT style_pk PRIMARY KEY ( style_artwork );

ALTER TABLE artwork
    ADD CONSTRAINT "ARTIST-ARTWORK" FOREIGN KEY ( artist_code )
        REFERENCES artist ( artist_code );

ALTER TABLE current_status
    ADD CONSTRAINT "ARTWORK-CURRENT_STATUS" FOREIGN KEY ( artwork_no,
                                                          artist_code )
        REFERENCES artwork ( artwork_no,
                             artist_code );

ALTER TABLE exhibition
    ADD CONSTRAINT "ARTWORK-EXHIBITION" FOREIGN KEY ( artwork_no,
                                                      artist_code )
        REFERENCES artwork ( artwork_no,
                             artist_code );

ALTER TABLE sale
    ADD CONSTRAINT "CUSTOMER-SALE" FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE sale
    ADD CONSTRAINT "EXHIBITION-SALE" FOREIGN KEY ( exhibition_no )
        REFERENCES exhibition ( exhibition_no );

ALTER TABLE current_status
    ADD CONSTRAINT "GALLERY-CURRENT_STATUS" FOREIGN KEY ( gallery_id )
        REFERENCES gallery ( gallery_id );

ALTER TABLE exhibition
    ADD CONSTRAINT "GALLERY-EXHIBITION" FOREIGN KEY ( gallery_id )
        REFERENCES gallery ( gallery_id );

ALTER TABLE artwork
    ADD CONSTRAINT "MEDIA_DESCRIPTION-_ARTWORK" FOREIGN KEY ( media_id )
        REFERENCES media_description ( media_id );

ALTER TABLE artwork
    ADD CONSTRAINT "STYLE-ARTWORK" FOREIGN KEY ( style_artwork )
        REFERENCES style ( style_artwork );

ALTER TABLE style
    ADD CONSTRAINT "STYLE-STYLE" FOREIGN KEY ( art_style )
        REFERENCES style ( style_artwork );

spool off
set echo off


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             1
-- ALTER TABLE                             25
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
