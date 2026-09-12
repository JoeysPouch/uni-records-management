-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(100) NOT NULL,
  `faculty` VARCHAR(100) NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`program` (
  `program_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `degree_awarded` VARCHAR(100) NULL,
  `duration` VARCHAR(50) NULL,
  PRIMARY KEY (`program_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`research_area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`research_area` (
  `area_id` INT NOT NULL AUTO_INCREMENT,
  `area_name` VARCHAR(100) NULL,
  PRIMARY KEY (`area_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`organization` (
  `organization_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`organization_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`committee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`committee` (
  `committee_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`committee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`lecturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`lecturer` (
  `lecturer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `course_load` INT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`lecturer_id`),
  INDEX `fk_lecturer_department_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_lecturer_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_code` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) NULL,
  `level` VARCHAR(20) NULL,
  `credits` INT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`course_code`),
  INDEX `fk_course_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `job_title` VARCHAR(100) NULL,
  `employment_type` VARCHAR(50) NULL,
  `salary` DECIMAL(10,2) NULL,
  `emergency_contact_name` VARCHAR(100) NULL,
  `emergency_contact_phone` VARCHAR(30) NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `fk_staff_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `date_of_birth` DATE NULL,
  `contact_email` VARCHAR(100) NULL,
  `contact_phone` VARCHAR(30) NULL,
  `year_of_study` INT NULL,
  `graduation_status` VARCHAR(50) NULL,
  `program_id` INT NOT NULL,
  `advisor_id` INT NOT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `fk_student_program1_idx` (`program_id` ASC) VISIBLE,
  INDEX `fk_student_lecturer1_idx` (`advisor_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_program1`
    FOREIGN KEY (`program_id`)
    REFERENCES `university`.`program` (`program_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_lecturer1`
    FOREIGN KEY (`advisor_id`)
    REFERENCES `university`.`lecturer` (`lecturer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course_offering`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`course_offering` (
  `offering_id` INT NOT NULL AUTO_INCREMENT,
  `semester` VARCHAR(20) NOT NULL,
  `year` INT NULL,
  `schedule` VARCHAR(100) NULL,
  `course_code` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`offering_id`),
  INDEX `fk_course_offering_course1_idx` (`course_code` ASC) VISIBLE,
  CONSTRAINT `fk_course_offering_course1`
    FOREIGN KEY (`course_code`)
    REFERENCES `university`.`course` (`course_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrolment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`enrolment` (
  `enrolment_id` INT NOT NULL AUTO_INCREMENT,
  `grade` DECIMAL(5,2) NULL,
  `status` VARCHAR(20) NULL,
  `enrolment_date` DATE NULL,
  `student_id` INT NOT NULL,
  `course_offering_id` INT NOT NULL,
  PRIMARY KEY (`enrolment_id`),
  INDEX `fk_enrolment_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_enrolment_course_offering1_idx` (`course_offering_id` ASC) VISIBLE,
  CONSTRAINT `fk_enrolment_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrolment_course_offering1`
    FOREIGN KEY (`course_offering_id`)
    REFERENCES `university`.`course_offering` (`offering_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course_assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`course_assignment` (
  `assignment_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(50) NULL,
  `lecturer_id` INT NOT NULL,
  `course_offering_id` INT NOT NULL,
  PRIMARY KEY (`assignment_id`),
  INDEX `fk_course_assignment_lecturer1_idx` (`lecturer_id` ASC) VISIBLE,
  INDEX `fk_course_assignment_course_offering1_idx` (`course_offering_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_assignment_lecturer1`
    FOREIGN KEY (`lecturer_id`)
    REFERENCES `university`.`lecturer` (`lecturer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_assignment_course_offering1`
    FOREIGN KEY (`course_offering_id`)
    REFERENCES `university`.`course_offering` (`offering_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`prog_course_req`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`prog_course_req` (
  `requirement_id` INT NOT NULL AUTO_INCREMENT,
  `requirement_type` VARCHAR(20) NULL,
  `program_id` INT NOT NULL,
  `course_code` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`requirement_id`),
  INDEX `fk_prog_course_req_program1_idx` (`program_id` ASC) VISIBLE,
  INDEX `fk_prog_course_req_course1_idx` (`course_code` ASC) VISIBLE,
  CONSTRAINT `fk_prog_course_req_program1`
    FOREIGN KEY (`program_id`)
    REFERENCES `university`.`program` (`program_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prog_course_req_course1`
    FOREIGN KEY (`course_code`)
    REFERENCES `university`.`course` (`course_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`org_membership`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`org_membership` (
  `membership_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(50) NULL,
  `join_date` DATE NULL,
  `student_id` INT NOT NULL,
  `organization_id` INT NOT NULL,
  PRIMARY KEY (`membership_id`),
  INDEX `fk_org_membership_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_org_membership_organization1_idx` (`organization_id` ASC) VISIBLE,
  CONSTRAINT `fk_org_membership_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_org_membership_organization1`
    FOREIGN KEY (`organization_id`)
    REFERENCES `university`.`organization` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`committee_membership`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`committee_membership` (
  `committee_membership_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(50) NULL,
  `term` VARCHAR(50) NULL,
  `lecturer_id` INT NOT NULL,
  `committee_id` INT NOT NULL,
  PRIMARY KEY (`committee_membership_id`),
  INDEX `fk_committee_membership_lecturer1_idx` (`lecturer_id` ASC) VISIBLE,
  INDEX `fk_committee_membership_committee1_idx` (`committee_id` ASC) VISIBLE,
  CONSTRAINT `fk_committee_membership_lecturer1`
    FOREIGN KEY (`lecturer_id`)
    REFERENCES `university`.`lecturer` (`lecturer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_committee_membership_committee1`
    FOREIGN KEY (`committee_id`)
    REFERENCES `university`.`committee` (`committee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`lecturer_expertise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`lecturer_expertise` (
  `expertise_id` INT NOT NULL AUTO_INCREMENT,
  `lecturer_id` INT NOT NULL,
  `research_area_id` INT NOT NULL,
  PRIMARY KEY (`expertise_id`),
  INDEX `fk_lecturer_expertise_lecturer1_idx` (`lecturer_id` ASC) VISIBLE,
  INDEX `fk_lecturer_expertise_research_area1_idx` (`research_area_id` ASC) VISIBLE,
  CONSTRAINT `fk_lecturer_expertise_lecturer1`
    FOREIGN KEY (`lecturer_id`)
    REFERENCES `university`.`lecturer` (`lecturer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lecturer_expertise_research_area1`
    FOREIGN KEY (`research_area_id`)
    REFERENCES `university`.`research_area` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`research_project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`research_project` (
  `project_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `principal_investigator_id` INT NOT NULL,
  PRIMARY KEY (`project_id`),
  INDEX `fk_research_project_lecturer1_idx` (`principal_investigator_id` ASC) VISIBLE,
  CONSTRAINT `fk_research_project_lecturer1`
    FOREIGN KEY (`principal_investigator_id`)
    REFERENCES `university`.`lecturer` (`lecturer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`project_membership`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`project_membership` (
  `project_membership_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(50) NULL,
  `research_project_id` INT NOT NULL,
  `lecturer_id` INT NULL,
  `student_id` INT NULL,
  PRIMARY KEY (`project_membership_id`),
  INDEX `fk_project_membership_research_project1_idx` (`research_project_id` ASC) VISIBLE,
  INDEX `fk_project_membership_lecturer1_idx` (`lecturer_id` ASC) VISIBLE,
  INDEX `fk_project_membership_student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_project_membership_research_project1`
    FOREIGN KEY (`research_project_id`)
    REFERENCES `university`.`research_project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_membership_lecturer1`
    FOREIGN KEY (`lecturer_id`)
    REFERENCES `university`.`lecturer` (`lecturer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_membership_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course_prerequisite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`course_prerequisite` (
  `prerequisite_id` INT NOT NULL AUTO_INCREMENT,
  `course_code` VARCHAR(20) NOT NULL,
  `prerequisite_course_code` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`prerequisite_id`),
  INDEX `fk_course_prerequisite_course1_idx` (`course_code` ASC) VISIBLE,
  INDEX `fk_course_prerequisite_course2_idx` (`prerequisite_course_code` ASC) VISIBLE,
  CONSTRAINT `fk_course_prerequisite_course1`
    FOREIGN KEY (`course_code`)
    REFERENCES `university`.`course` (`course_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_prerequisite_course2`
    FOREIGN KEY (`prerequisite_course_code`)
    REFERENCES `university`.`course` (`course_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`research_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`research_group` (
  `group_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `head_lecturer_id` INT NOT NULL,
  PRIMARY KEY (`group_id`),
  INDEX `fk_research_group_lecturer1_idx` (`head_lecturer_id` ASC) VISIBLE,
  CONSTRAINT `fk_research_group_lecturer1`
    FOREIGN KEY (`head_lecturer_id`)
    REFERENCES `university`.`lecturer` (`lecturer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`student_employment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student_employment` (
  `employment_id` INT NOT NULL AUTO_INCREMENT,
  `job_title` VARCHAR(100) NULL,
  `student_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  `program_id` INT NOT NULL,
  `supervisor_id` INT NOT NULL,
  PRIMARY KEY (`employment_id`),
  INDEX `fk_student_employment_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_student_employment_department1_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_student_employment_program1_idx` (`program_id` ASC) VISIBLE,
  INDEX `fk_student_employment_staff1_idx` (`supervisor_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_employment_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_employment_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_employment_program1`
    FOREIGN KEY (`program_id`)
    REFERENCES `university`.`program` (`program_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_employment_staff1`
    FOREIGN KEY (`supervisor_id`)
    REFERENCES `university`.`staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`student_disciplinary_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student_disciplinary_record` (
  `record_id` INT NOT NULL AUTO_INCREMENT,
  `record_date` DATE NULL,
  `description` VARCHAR(255) NULL,
  `action_taken` VARCHAR(100) NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`record_id`),
  INDEX `fk_student_disciplinary_record_student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_disciplinary_record_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`lecturer_qualification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`lecturer_qualification` (
  `qualification_id` INT NOT NULL AUTO_INCREMENT,
  `qualification` VARCHAR(100) NULL,
  `institution` VARCHAR(100) NULL,
  `year` INT NULL,
  `lecturer_id` INT NOT NULL,
  PRIMARY KEY (`qualification_id`),
  INDEX `fk_lecturer_qualification_lecturer1_idx` (`lecturer_id` ASC) VISIBLE,
  CONSTRAINT `fk_lecturer_qualification_lecturer1`
    FOREIGN KEY (`lecturer_id`)
    REFERENCES `university`.`lecturer` (`lecturer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`lecturer_publication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`lecturer_publication` (
  `publication_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NULL,
  `venue` VARCHAR(150) NULL,
  `publication_date` DATE NULL,
  `lecturer_id` INT NOT NULL,
  PRIMARY KEY (`publication_id`),
  INDEX `fk_lecturer_publication_lecturer1_idx` (`lecturer_id` ASC) VISIBLE,
  CONSTRAINT `fk_lecturer_publication_lecturer1`
    FOREIGN KEY (`lecturer_id`)
    REFERENCES `university`.`lecturer` (`lecturer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course_material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`course_material` (
  `material_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NULL,
  `type` VARCHAR(50) NULL,
  `link` VARCHAR(255) NULL,
  `offering_id` INT NOT NULL,
  PRIMARY KEY (`material_id`),
  INDEX `fk_course_material_course_offering1_idx` (`offering_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_material_course_offering1`
    FOREIGN KEY (`offering_id`)
    REFERENCES `university`.`course_offering` (`offering_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department_research_area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`department_research_area` (
  `dept_area_id` INT NOT NULL AUTO_INCREMENT,
  `department_id` INT NOT NULL,
  `research_area_id` INT NOT NULL,
  INDEX `fk_department_research_area_department1_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_department_research_area_research_area1_idx` (`research_area_id` ASC) VISIBLE,
  PRIMARY KEY (`dept_area_id`),
  CONSTRAINT `fk_department_research_area_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_department_research_area_research_area1`
    FOREIGN KEY (`research_area_id`)
    REFERENCES `university`.`research_area` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`project_funding_source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`project_funding_source` (
  `funding_id` INT NOT NULL AUTO_INCREMENT,
  `source_name` VARCHAR(150) NULL,
  `amount` DECIMAL(12,2) NULL,
  `research_project_id` INT NOT NULL,
  PRIMARY KEY (`funding_id`),
  INDEX `fk_project_funding_source_research_project1_idx` (`research_project_id` ASC) VISIBLE,
  CONSTRAINT `fk_project_funding_source_research_project1`
    FOREIGN KEY (`research_project_id`)
    REFERENCES `university`.`research_project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`project_publication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`project_publication` (
  `project_pub_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NULL,
  `venue` VARCHAR(150) NULL,
  `publication_date` DATE NULL,
  `research_project_id` INT NOT NULL,
  PRIMARY KEY (`project_pub_id`),
  INDEX `fk_project_publication_research_project1_idx` (`research_project_id` ASC) VISIBLE,
  CONSTRAINT `fk_project_publication_research_project1`
    FOREIGN KEY (`research_project_id`)
    REFERENCES `university`.`research_project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`project_outcome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`project_outcome` (
  `outcome_id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NULL,
  `research_project_id` INT NOT NULL,
  PRIMARY KEY (`outcome_id`),
  INDEX `fk_project_outcome_research_project1_idx` (`research_project_id` ASC) VISIBLE,
  CONSTRAINT `fk_project_outcome_research_project1`
    FOREIGN KEY (`research_project_id`)
    REFERENCES `university`.`research_project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`staff_contract_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`staff_contract_detail` (
  `contract_id` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `contract_type` VARCHAR(50) NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`contract_id`),
  INDEX `fk_staff_contract_detail_staff1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_contract_detail_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `university`.`staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
