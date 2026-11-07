-- =====================================================================
-- Chenab Hostel Allotment Workflow Schema Extension
-- Implements the 5-step allotment workflow:
-- 1. Apply (student preferences)
-- 2. Verify (college record check)
-- 3. Rank (rules stored in database table, not hardcoded)
-- 4. Allocate (matching + warden overrides)
-- 5. Swap & Vacancy (swap matching, warden approvals, vacancies reopen)
-- =====================================================================

USE `chenab_hostel_db`;

-- ---------------------------------------------------------------------
-- 1. Table for Dynamic Allotment Rules (Kept in a table, not hardcoded)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `allotment_rules` (
  `rule_id` INT NOT NULL AUTO_INCREMENT,
  `rule_code` VARCHAR(50) NOT NULL UNIQUE,
  `rule_name` VARCHAR(120) NOT NULL,
  `criteria_type` ENUM('YEAR_OF_STUDY', 'MERIT_CGPA', 'APPLICATION_TIME', 'DISTANCE', 'CUSTOM') NOT NULL,
  `weight` DECIMAL(5,2) NOT NULL DEFAULT '1.00',
  `priority_order` INT NOT NULL DEFAULT '1',
  `is_active` TINYINT(1) NOT NULL DEFAULT '1',
  `description` VARCHAR(255) DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed default priority rules (as shown in specification):
-- "final-year students first, then merit, then time of application"
INSERT INTO `allotment_rules` (`rule_code`, `rule_name`, `criteria_type`, `weight`, `priority_order`, `is_active`, `description`)
VALUES
  ('FINAL_YEAR_PRIORITY', 'Final Year Student Preference', 'YEAR_OF_STUDY', 40.00, 1, 1, '4th year students get highest weight in room selection'),
  ('ACADEMIC_MERIT', 'Academic CGPA / Merit Score', 'MERIT_CGPA', 35.00, 2, 1, 'Merit score out of 10.0 multiplied by weight'),
  ('TIMESTAMP_FCFS', 'Application Timestamp (First-come first-served)', 'APPLICATION_TIME', 25.00, 3, 1, 'Earlier submission time awards higher tier points')
ON DUPLICATE KEY UPDATE `rule_name` = VALUES(`rule_name`);

-- ---------------------------------------------------------------------
-- 2. Table for Allotment Applications (Apply & Preferences)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `allotment_applications` (
  `application_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `preferred_room_type` ENUM('STANDARD', 'DELUXE') NOT NULL DEFAULT 'STANDARD',
  `preferred_floor` TINYINT DEFAULT NULL,
  `preferred_roommate_enrolment` VARCHAR(20) DEFAULT NULL,
  `special_requirements` VARCHAR(255) DEFAULT NULL,
  `cgpa` DECIMAL(4,2) NOT NULL DEFAULT '7.50',
  `year_of_study` TINYINT NOT NULL DEFAULT '1',
  `verification_status` ENUM('PENDING', 'VERIFIED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
  `verification_notes` VARCHAR(255) DEFAULT NULL,
  `verified_by` INT DEFAULT NULL,
  `calculated_score` DECIMAL(7,2) DEFAULT '0.00',
  `priority_rank` INT DEFAULT NULL,
  `application_status` ENUM('APPLIED', 'VERIFIED', 'RANKED', 'ALLOCATED', 'REJECTED') NOT NULL DEFAULT 'APPLIED',
  `allocated_room_id` INT DEFAULT NULL,
  `applied_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`application_id`),
  UNIQUE KEY `uq_student_application` (`student_id`),
  KEY `fk_app_student` (`student_id`),
  KEY `fk_app_room` (`allocated_room_id`),
  CONSTRAINT `fk_app_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `fk_app_room` FOREIGN KEY (`allocated_room_id`) REFERENCES `rooms` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 3. Table for Room Swap Requests (Swap & Vacancy)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `room_swap_requests` (
  `swap_id` INT NOT NULL AUTO_INCREMENT,
  `requester_student_id` INT NOT NULL,
  `target_student_id` INT NOT NULL,
  `requester_room_id` INT NOT NULL,
  `target_room_id` INT NOT NULL,
  `reason` VARCHAR(255) NOT NULL,
  `peer_consent` ENUM('PENDING', 'ACCEPTED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
  `warden_status` ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
  `reviewed_by` INT DEFAULT NULL,
  `review_notes` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `resolved_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`swap_id`),
  KEY `fk_swap_req_student` (`requester_student_id`),
  KEY `fk_swap_target_student` (`target_student_id`),
  CONSTRAINT `fk_swap_req_student` FOREIGN KEY (`requester_student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `fk_swap_target_student` FOREIGN KEY (`target_student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
