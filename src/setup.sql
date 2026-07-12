-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(200) NOT NULL,
    logo_filename VARCHAR(200) NOT NULL
);


-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');



-- ============================================================
-- Service Project table
-- Each project belongs to exactly one sponsoring organization.
-- ============================================================
CREATE TABLE service_project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(200) NOT NULL,
    project_date DATE NOT NULL,
    CONSTRAINT fk_service_project_organization
        FOREIGN KEY (organization_id)
        REFERENCES organization (organization_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- Foreign-key columns are not automatically indexed by PostgreSQL.
CREATE INDEX idx_service_project_organization_id
    ON service_project (organization_id);



-- ============================================================
-- Data: five projects for each of the three organizations
-- Organization IDs are looked up by name in the INSERT statement below.
-- ============================================================
INSERT INTO service_project
    (organization_id, title, description, location, project_date)
SELECT
    organization.organization_id,
    project.title,
    project.description,
    project.location,
    project.project_date
FROM organization
JOIN (
    VALUES
        ('BrightFuture Builders', 'Community Center Painting', 'Prepare and repaint the community center meeting rooms.', 'Riverside Community Center', DATE '2026-07-25'),
        ('BrightFuture Builders', 'Neighborhood Ramp Build', 'Build an accessibility ramp for a local resident.', 'Maple Street Neighborhood', DATE '2026-08-08'),
        ('BrightFuture Builders', 'Playground Repair Day', 'Repair benches and replace damaged playground fixtures.', 'Oakwood Park', DATE '2026-08-29'),
        ('BrightFuture Builders', 'School Garden Shed Build', 'Construct a weather-resistant storage shed for garden tools.', 'Lincoln Elementary School', DATE '2026-09-19'),
        ('BrightFuture Builders', 'Community Roof Repair', 'Assist skilled volunteers with repairs to a nonprofit facility roof.', 'Hope Outreach Center', DATE '2026-10-10'),

        ('GreenHarvest Growers', 'Urban Garden Planting', 'Plant seasonal vegetables in the neighborhood garden.', 'Eastside Community Garden', DATE '2026-07-18'),
        ('GreenHarvest Growers', 'Composting Workshop', 'Set up composting stations and teach residents how to use them.', 'GreenHarvest Learning Farm', DATE '2026-08-01'),
        ('GreenHarvest Growers', 'Fresh Produce Harvest', 'Harvest and package fresh produce for local food pantries.', 'Northside Urban Farm', DATE '2026-08-22'),
        ('GreenHarvest Growers', 'School Garden Mentoring', 'Help students maintain garden beds and learn sustainable growing.', 'Roosevelt Middle School', DATE '2026-09-12'),
        ('GreenHarvest Growers', 'Community Orchard Care', 'Prune trees, spread mulch, and clean the community orchard.', 'Willow Creek Orchard', DATE '2026-10-03'),

        ('UnityServe Volunteers', 'Weekend Food Drive', 'Collect, sort, and prepare donated food for distribution.', 'UnityServe Donation Center', DATE '2026-07-19'),
        ('UnityServe Volunteers', 'Senior Center Activity Day', 'Lead games, crafts, and social activities for senior residents.', 'Golden Years Senior Center', DATE '2026-08-15'),
        ('UnityServe Volunteers', 'Back-to-School Supply Sort', 'Sort donated school supplies into student distribution kits.', 'Downtown Volunteer Hub', DATE '2026-08-30'),
        ('UnityServe Volunteers', 'Community Tutoring Night', 'Tutor local students in reading, mathematics, and science.', 'West End Public Library', DATE '2026-09-24'),
        ('UnityServe Volunteers', 'Winter Clothing Collection', 'Collect and organize warm clothing for families in need.', 'UnityServe Donation Center', DATE '2026-11-07')
) AS project (organization_name, title, description, location, project_date)
    ON organization.name = project.organization_name;
