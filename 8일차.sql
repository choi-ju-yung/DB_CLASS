-- 트리거로 재고 관리하기 
create table tbl_product(
    pcode NUMBER PRIMARY KEY,
    PNAME VARCHAR2(20) NOT NULL,
    BRAND VARCHAR2(20),
    PRICE NUMBER CHECK(PRICE > 0),
    STOCK NUMBER DEFAULT 0
);

CREATE SEQUENCE SEQ_PRO;
CREATE TABLE TBL_PROIO(
    IOCODE NUMBER PRIMARY KEY,
    PCODE NUMBER REFERENCES TBL_PRODUCT(PCODE),
    IODATE DATE,
    AMOUNT NUMBER CHECK(AMOUNT >0),
    STATUS VARCHAR2(10) CHECK(STATUS IN('입고','출고'))  
);
CREATE SEQUENCE SEQ_PROIO;

SELECT * FROM tbl_product;
SELECT * FROM TBL_PROIO;
INSERT INTO tbl_product VALUES(SEQ_PRO.NEXTVAL,'랜드로버','랜드로버',80000000,DEFAULT);
INSERT INTO tbl_product VALUES(SEQ_PRO.NEXTVAL,'맥북프로','애플',2800000,DEFAULT);
INSERT INTO tbl_product VALUES(SEQ_PRO.NEXTVAL,'에어컨','삼성',1300000,DEFAULT);
INSERT INTO tbl_product VALUES(SEQ_PRO.NEXTVAL,'아이패드','애플',1600000,DEFAULT);
SELECT * FROM tbl_product;

INSERT INTO TBL_PROIO VALUES(SEQ_PROIO.NEXTVAL,1,SYSDATE,10,'입고');
INSERT INTO TBL_PROIO VALUES(SEQ_PROIO.NEXTVAL,2,SYSDATE,7,'입고');
INSERT INTO TBL_PROIO VALUES(SEQ_PROIO.NEXTVAL,2,SYSDATE,3,'출고');
SELECT * FROM TBL_PROIO;
DELETE FROM TBL_PROIO;
COMMIT;

CREATE OR REPLACE TRIGGER TRG_PRODUCT  -- 트리거를 통해서 STOCK 컬럼을 수정하게 하는 작업 (수량 수정)
AFTER INSERT ON TBL_PROIO              -- 트리거는 커밋을 자동으로 해줌 (굳이 넣을필요없음)
FOR EACH ROW
BEGIN
    IF :NEW.STATUS='입고'
        THEN UPDATE TBL_PRODUCT SET STOCK = STOCK +: NEW.AMOUNT WHERE :NEW.PCODE = PCODE;
    ELSIF :NEW.STATUS='출고'
        THEN UPDATE TBL_PRODUCT SET STOCK = STOCK -: NEW.AMOUNT WHERE :NEW.PCODE = PCODE;
    END IF;
END;




