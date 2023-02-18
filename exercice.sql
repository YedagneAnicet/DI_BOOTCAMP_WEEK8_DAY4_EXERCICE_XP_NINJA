CREATE TABLE accounts(
    id SERIAL PRIMARY KEY,
    first_name CHARACTER VARYING(100),
    last_name CHARACTER VARYING(100)
);
CREATE TABLE plans(
    id SERIAL PRIMARY KEY,
    plan CHARACTER VARYING(10) NOT NULL
);
CREATE TABLE account_plans(
    account_id INTEGER NOT NULL,
    plan_id INTEGER NOT NULL,
    effective_date DATE NOT NULL,
    PRIMARY KEY (account_id, plan_id),
    FOREIGN KEY(account_id) REFERENCES accounts(id),
    FOREIGN KEY(plan_id) REFERENCES plans(id)
);
INSERT INTO plans(plan)
VALUES('SILVER'),
    ('GOLD'),
    ('PLATINUM');
--to connect to the database
psql - U postgres - d xpninja --Insert three accounts with silver, gold, and platinum levels.
INSERT INTO accounts(first_name, last_name)
VALUES('Yann', 'YAO');
INSERT INTO accounts(first_name, last_name)
VALUES('Aymar', 'Yann');
INSERT INTO accounts(first_name, last_name)
VALUES('Yao', 'Kouadio');
INSERT INTO account_plans(account_id, plan_id, effective_date)
VALUES(1, 3, CURRENT_DATE);
INSERT INTO account_plans(account_id, plan_id, effective_date)
VALUES(2, 1, CURRENT_DATE);
INSERT INTO account_plans(account_id, plan_id, effective_date)
VALUES(3, 2, CURRENT_DATE);
--Try to insert one more account but with a plan id that does not exist in the plans table. Based on the input, the step of assigning the plan to the account should fails that cause the whole transaction to be rolled back.
INSERT INTO accounts(first_name, last_name)
VALUES('Yao', 'Nelly');
INSERT INTO account_plans(account_id, plan_id, effective_date)
VALUES(4, 4, CURRENT_DATE);
--Since the plan id 4 does not exist in the plans table, the second INSERT statement will fail and the whole transaction will be rolled back automatically