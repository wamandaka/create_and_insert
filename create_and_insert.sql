CREATE TABLE nasabah (
	id SERIAL PRIMARY KEY NOT NULL,
	nama VARCHAR(50) NOT NULL,
	alamat VARCHAR(255) NOT NULL,
	no_telp VARCHAR(15),
	email VARCHAR(50),
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW(),
	deleted_at TIMESTAMP
);

CREATE TABLE akun (
	id SERIAL PRIMARY KEY NOT NULL,
	id_nasabah INT NOT NULL,
	saldo FLOAT,
	jenis_akun VARCHAR(15),
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW(),
	deleted_at TIMESTAMP,
	CONSTRAINT fk_nasabah
		FOREIGN KEY(id_nasabah)
			REFERENCES nasabah(id)
);

CREATE TABLE transaksi (
	id SERIAL PRIMARY KEY NOT NULL,
	id_akun INT NOT NULL,
	tgl_transaksi TIMESTAMP NOT NULL DEFAULT NOW(),
	desk_transaksi TEXT,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT NOW(),
	deleted_at TIMESTAMP,
	CONSTRAINT fk_akun
		FOREIGN KEY(id_akun)
			REFERENCES akun(id)
);

-- ubah tipe data pada table nasabah kolom no_telp
ALTER TABLE akun
ALTER COLUMN saldo TYPE BIGINT;

-- ALTER TABLE nasabah ADD COLUMN created_at TIMESTAMP;

DROP TABLE nasabah, akun, transaksi;

-- CREATE 
INSERT INTO nasabah(
	nama,
	alamat,
	no_telp,
	email
) VALUES 
('daka','jakarta','081234567890','wamandaka122@gmail.com'),
('nahida','sumeru','081234567890','wamandaka122@gmail.com'),
('diluc','mondstadt','081234567890','wamandaka122@gmail.com'),
('keqing','liyue','081234567890','wamandaka122@gmail.com'),
('focalors','fontaine','081234567890','wamandaka122@gmail.com'),
('hutao','liyue','081234567890','wamandaka122@gmail.com'),
('Rosalyne-Kruzchka Lohefalter','mondstadt','081234567890','wamandaka122@gmail.com');

INSERT INTO akun(
	id_nasabah,
	saldo,
	jenis_akun
) VALUES
('1','10000','gold'),
('2','20000','silver'),
('3','30000','bronze'),
('4','40000','bronze'),
('5','50000','gold'),
('6','60000','silver'),
('7','70000','gold');

INSERT INTO transaksi(
	id_akun,
	desk_transaksi
) VALUES
('1','berhasil'),
('2','berhasil'),
('3','berhasil'),
('4','berhasil'),
('5','berhasil'),
('6','berhasil'),
('7','berhasil');

-- READ
SELECT * FROM nasabah;
SELECT * FROM akun;
SELECT * FROM transaksi;

SELECT * FROM nasabah INNER JOIN akun on nasabah.id=akun.id_nasabah;

-- UPDATE
UPDATE nasabah
SET
alamat = 'bandung'
where nama = 'putri';

CREATE OR REPLACE PROCEDURE transfer (
    idPengirim INT,
    idPenerima INT,
    nominal DECIMAL(15, 2)
)
LANGUAGE plpgsql
as $$
BEGIN
    -- Mengupdate saldo akun pengirim
    UPDATE akun
    SET Saldo = Saldo - nominal
    WHERE Id = idPengirim;
    -- Mengupdate saldo akun penerima
    UPDATE akun
    SET Saldo = Saldo + nominal
    WHERE Id = idPenerima;

    COMMIT;
END;
$$;

CALL transfer(2, 3, 1000.00);

-- QUERY CTE
WITH nasabah_saldo AS (
    SELECT nama,saldo
    FROM nasabah INNER JOIN akun
    ON nasabah.Id = akun.Id_Nasabah
)

SELECT nama, saldo FROM nasabah_saldo;
ORDER BY nama ASC;


-- DELETE
DELETE FROM nasabah;

CREATE INDEX idx_nasabah_alamat ON "nasabah" (alamat);
SELECT * FROM "nasabah" WHERE alamat = 'sumeru';

DROP INDEX idx_nasabah_alamat;