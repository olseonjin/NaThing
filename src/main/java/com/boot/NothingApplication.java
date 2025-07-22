package com.boot;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.boot.DAO")
@SpringBootApplication
public class NothingApplication {

	public static void main(String[] args) {
		SpringApplication.run(NothingApplication.class, args);
	}

}
