package kr.co.kosmo.mvc.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import kr.co.kosmo.mvc.service.SongService;

@Configuration
@EnableScheduling
public class ScheduledConfig {
	@Autowired
	SongService songService;
	
	@Scheduled(cron="0 0 05 * * ?")
	public void deleteUserSongRecord() {
		songService.deleteUserSongRecord();
	}
}
