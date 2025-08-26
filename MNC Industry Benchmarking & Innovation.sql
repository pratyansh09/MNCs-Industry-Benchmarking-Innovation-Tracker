create database mnc_innovation;
use mnc_innovation;

-- Companies table
CREATE TABLE companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    country VARCHAR(50),
    industry VARCHAR(50)
);

-- Domains table
CREATE TABLE Domains (
    domain_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

-- Projects table
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT,
    project_name VARCHAR(100),
    domain_id INT,
    start_date DATE,
    end_date DATE,
    description TEXT,
    status VARCHAR(20),
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id)
);

-- Acquisitions table
CREATE TABLE acquisitions (
    acq_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT,
    target_company VARCHAR(100),
    domain_id INT,
    acq_date DATE,
    amount BIGINT,
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id)
);

-- Patents table
CREATE TABLE patents (
    patent_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT,
    domain_id INT,
    patent_title VARCHAR(200),
    filing_date DATE,
    grant_date DATE,
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id)
);

-- R&D Investments table
CREATE TABLE rd_investments (
    investment_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT,
    domain_id INT,
    year INT,
    amount_usd BIGINT,
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id)
);

INSERT INTO companies (name, country, industry) VALUES
('Google', 'USA', 'Technology'),
('Microsoft', 'USA', 'Technology'),
('Amazon', 'USA', 'E-commerce'),
('TCS', 'India', 'IT Services'),
('Siemens', 'Germany', 'Engineering'),
('IBM', 'USA', 'Technology');

INSERT INTO domains (name) VALUES
('AI'),
('Cloud'),
('Healthcare'),
('FinTech'),
('IoT'),
('Sustainability');

INSERT INTO projects (company_id, project_name, domain_id, start_date, end_date, description, status) VALUES
(1, 'Google Health AI', 3, '2023-01-15', NULL, 'Developing AI models for healthcare diagnostics', 'Active'),
(2, 'Azure Quantum', 1, '2022-05-10', NULL, 'Quantum computing platform on Azure Cloud', 'Active'),
(3, 'Amazon Sustainability Data Initiative', 6, '2021-07-01', NULL, 'Data resources for climate research', 'Active'),
(4, 'TCS BaNCS Cloud', 2, '2022-02-20', '2025-01-01', 'Banking software suite on the cloud', 'Completed'),
(5, 'Siemens MindSphere', 5, '2021-03-10', NULL, 'Industrial IoT as a service solution', 'Active'),
(6, 'IBM Watson Health', 3, '2020-11-01', NULL, 'AI-powered healthcare analytics', 'Active');

INSERT INTO acquisitions (company_id, target_company, domain_id, acq_date, amount) VALUES
(1, 'DeepMind', 1, '2014-01-26', 500000000),
(2, 'Nuance Communications', 3, '2021-04-12', 19700000000),
(3, 'PillPack', 3, '2018-06-28', 753000000),
(4, 'Bridgepoint', 2, '2019-08-15', 100000000),
(5, 'Mentor Graphics', 5, '2016-11-14', 4500000000),
(6, 'Explorys', 3, '2015-04-08', 100000000);

INSERT INTO patents (company_id, domain_id, patent_title, filing_date, grant_date) VALUES
(1, 1, 'AI Model Optimization', '2022-03-15', '2023-04-10'),
(2, 2, 'Cloud Resource Allocation', '2021-06-20', '2022-09-12'),
(3, 6, 'Sustainable Packaging', '2023-01-05', NULL),
(4, 2, 'Banking Transaction Security', '2022-07-30', '2023-03-01'),
(5, 5, 'Smart Factory Automation', '2021-02-18', '2022-05-20'),
(6, 3, 'Medical Data Analysis with AI', '2023-06-01', NULL);

INSERT INTO rd_investments (company_id, domain_id, year, amount_usd) VALUES
(1, 1, 2023, 1500000000),
(2, 1, 2023, 1200000000),
(3, 6, 2023, 700000000),
(4, 2, 2023, 500000000),
(5, 5, 2023, 400000000),
(6, 3, 2023, 800000000);

-- Top Innovators in AI
SELECT c.name, COUNT(p.project_id) AS ai_projects
FROM companies c
JOIN projects p ON c.company_id = p.company_id
JOIN domains d ON p.domain_id = d.domain_id
WHERE d.name = 'AI'
GROUP BY c.name
ORDER BY ai_projects DESC;

-- MNCs with Most Patents in HealthCare
SELECT c.name, COUNT(pt.patent_id) AS healthcare_patents
FROM companies c
JOIN patents pt ON c.company_id = pt.company_id
JOIN domains d ON pt.domain_id = d.domain_id
WHERE d.name = 'Healthcare'
GROUP BY c.name
ORDER BY healthcare_patents DESC;

-- Total R&D Investment by Domain(2023)
SELECT c.name, COUNT(pt.patent_id) AS healthcare_patents
FROM companies c
JOIN patents pt ON c.company_id = pt.company_id
JOIN domains d ON pt.domain_id = d.domain_id
WHERE d.name = 'Healthcare'
GROUP BY c.name
ORDER BY healthcare_patents DESC;

-- Acquisitions by Domain in Recent Years
SELECT d.name AS domain, SUM(r.amount_usd) AS total_investment
FROM rd_investments r
JOIN domains d ON r.domain_id = d.domain_id
WHERE r.year = 2023
GROUP BY d.name
ORDER BY total_investment DESC;

SELECT d.name AS domain, COUNT(a.acq_id) AS total_acquisitions
FROM acquisitions a
JOIN domains d ON a.domain_id = d.domain_id
WHERE a.acq_date BETWEEN '2020-01-01' AND '2025-12-31'
GROUP BY d.name
ORDER BY total_acquisitions DESC;